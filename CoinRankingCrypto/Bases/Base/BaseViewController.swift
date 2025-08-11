import AVFoundation
import CoinRankingCryptoDependencyInjection
import CoinRankingCryptoDomain
import enum CoinRankingCryptoDomain.SBErrors
import DGCharts
import MaterialComponents
import Photos
import RxSwift
import SnapKit

class BaseViewController: UIViewController, RxBaseProtocol, UIGestureRecognizerDelegate {
    var disposeBag = DisposeBag()
    private var loadingContainerView: UIView?
    private var activityIndicator: UIActivityIndicatorView?
    private var loadingAlert: UIAlertController?
    private var loadingView: UIView?
    lazy var searchResultsController = SearchResultsViewController()
    lazy var searchController = UISearchController(searchResultsController: searchResultsController)
    lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.attributedTitle = NSAttributedString(
            string: "Pull to refresh",
            attributes: [.foregroundColor: UIColor.label, .font: UIFont.systemFont(ofSize: 14)]
        )
        control.tintColor = .label
        return control
    }()

    let sortButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sort: Price ▼", for: .normal)
        button.titleLabel?.font = .SBFont.medium.font(14)
        button.setTitleColor(.label, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    enum SortOption {
        case price
        case performance
    }

    var currentSortOption: SortOption = .price

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        appWindow?.subviews.forEach { view in
            if view is SBSnackBarView {
                view.removeFromSuperview()
            }
        }
    }

    func configureSearchController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Strings.authSearch.localized()
        let searchTextField = searchController.searchBar.searchTextField
        searchTextField.backgroundColor = .systemGray5
        searchTextField.addCornerRadius(8)
        searchTextField.textColor = .label
        searchTextField.tintColor = .label

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    func updateSearchResults(for _: UISearchController) {}

    func sortedCoins(from coins: [HomeUITableViewCell.UIModel], by option: SortOption) -> [HomeUITableViewCell.UIModel] {
        switch option {
        case .price:
            return coins.sorted { (Double($0.price) ?? 0) > (Double($1.price) ?? 0) }
        case .performance:
            return coins.sorted { $0.performance > $1.performance }
        }
    }

    func showSnackError(_ error: Error, _ hideAfter: Bool = true) {
        let timeToHide: Double? = hideAfter ? 4 : nil
        switch error {
        case let SBErrors.apiError(_, message, _, _):
            let model = SBSnackBarView.ViewModel(messageText: message.isEmpty ? Strings.commonGeneralError.localized() : message,
                                                 buttonText: Strings.commonOkay.localized().uppercased())
            showSnackBar(model, timeToHide)

        case let SBErrors.retryError(message, retryAction):
            let model = SBSnackBarView.ViewModel(messageText: message.isEmpty ? Strings.commonGeneralError.localized() : message,
                                                 buttonText: Strings.commonTryAgain.localized().uppercased())
            showSnackBar(model, timeToHide, retryAction)

        default:
            let model = SBSnackBarView.ViewModel(messageText: error.localizedDescription,
                                                 buttonText: Strings.commonOkay.localized().uppercased())
            showSnackBar(model, timeToHide)
        }
    }

    func isNoInternetError(_ error: Error) -> Bool {
        switch error {
        case SBErrors.internetError:
            return true
        default:
            return false
        }
    }

    func showSuccessMessage(
        _ message: String,
        duration _: TimeInterval = 2.0,
        onOkayClicked: (() -> Void)? = nil
    ) {
        let model = SBSnackBarView.ViewModel(
            messageText: message,
            buttonText: Strings.commonOkay.localized().uppercased(),
            isSuccess: true
        )

        showSnackBar(model, 3, onOkayClicked)
    }

    func showSnackBar(_ model: SBSnackBarView.ViewModel,
                      _ hideAfter: Double? = nil,
                      _ retryClosure: (() -> Void)? = nil)
    {
        let snackBar = SBSnackBarView(model)
        if let retryClosure = retryClosure {
            snackBar.setConfirmClosure(retryClosure)
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view.endEditing(true)
            UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
                appWindow?.addSubview(snackBar)
                snackBar.pinToSuperview()
            }) { _ in
                guard let hideAfter = hideAfter else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + hideAfter) { [weak self] in
                    guard let self = self else { return }
                    UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        snackBar.removeFromSuperview()
                    }, completion: nil)
                }
            }
        }
    }

    func keyboardHeight(notification: NSNotification) -> CGFloat {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            return keyboardRectangle.height
        }
        return 0
    }

    func updateLoading(_ show: Bool, _ view: UIView, _ isOverlay: Bool = false) {
        if show {
            showLoading()
        } else {
            hideLoading()
        }
    }

    private func showLoading() {
        guard loadingContainerView == nil else { return }

        let containerView = UIView()
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        containerView.layer.cornerRadius = 10

        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemOrange
        indicator.startAnimating()

        containerView.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(50)
        }

        if let keyWindow = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) {

            keyWindow.addSubview(containerView)
            containerView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.width.height.equalTo(80)
            }
            
            loadingContainerView = containerView
            activityIndicator = indicator
        }
    }

    private func hideLoading() {
        activityIndicator?.stopAnimating()
        loadingContainerView?.removeFromSuperview()
        activityIndicator = nil
        loadingContainerView = nil
    }

    func isShowingSnackBar() -> Bool {
        var result = false
        appWindow?.subviews.forEach { view in
            if view is SBSnackBarView {
                result = true
            }
        }
        return result
    }

    @objc func popToSpecificController(_ targetViewController: UIViewController) {
        guard let viewControllers = navigationController?.viewControllers else { return }

        if viewControllers.contains(targetViewController) {
            navigationController?.popToViewController(targetViewController, animated: true)
        }
    }
}
