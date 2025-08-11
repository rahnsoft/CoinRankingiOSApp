
import UIKit

extension UINavigationBar {
    func largeTitles(enabled: Bool) {
        if #available(iOS 11.0, *) {
            self.prefersLargeTitles = enabled
        }
    }
}

extension UINavigationController {
    func popBack(_ nb: Int) {
        let viewControllers: [UIViewController] = self.viewControllers
        guard viewControllers.count < nb else {
            popToViewController(viewControllers[viewControllers.count - nb], animated: true)
            return
        }
    }

    /// pop back to specific viewcontroller
    func popBack<T: UIViewController>(toControllerType: T.Type) {
        var viewControllers: [UIViewController] = self.viewControllers
        viewControllers = viewControllers.reversed()
        for currentViewController in viewControllers {
            if currentViewController.isKind(of: toControllerType) {
                popToViewController(currentViewController, animated: true)
                break
            }
        }
    }
}
