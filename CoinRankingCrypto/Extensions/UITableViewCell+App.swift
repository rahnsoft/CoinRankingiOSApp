
import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }

    func getDisclosure(_ frame: CGRect) -> UITableViewCell {
        self.frame = frame
        accessoryType = .disclosureIndicator
        isUserInteractionEnabled = false
        return self
    }
}
