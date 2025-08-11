
import UIKit

extension UICollectionView {
    var twoColumnsMargin: CGFloat {
        return 30
    }

    func register(_ identifier: String) {
        register(UINib(nibName: identifier, bundle: nil),
                 forCellWithReuseIdentifier: identifier)
    }

    func cellWidthForTwoColumns() -> CGFloat {
        return (bounds.width - twoColumnsMargin) / 2
    }
}
