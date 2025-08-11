
import UIKit

extension NSMutableAttributedString {
    func setFont(_ text: String, font: UIFont) {
        let range: NSRange = mutableString.range(of: text, options: .caseInsensitive)
        addAttribute(NSAttributedString.Key.font, value: font, range: range)
    }

    func changeFont(_ texts: [String], font: UIFont, textColor: UIColor = .systemOrange, underLineStyle: NSUnderlineStyle? = nil) {
        for text in texts {
            let range = (string as NSString).range(of: text)
            addAttributes([NSAttributedString.Key.foregroundColor: textColor,
                           NSAttributedString.Key.font: font],
                          range: range)
            if let underLineStyle = underLineStyle {
                addAttributes(
                    [NSAttributedString.Key.underlineStyle: underLineStyle.rawValue],
                    range: range
                )
            }
        }
    }

    func changeFontInRange(_ rangeString: String, _ font: UIFont, _ textColor: UIColor = .systemOrange) {
        let fullText = string as NSString
        let range = fullText.range(of: rangeString, options: .caseInsensitive)

        guard range.location != NSNotFound else {
            sPrint("Range string '\(rangeString)' not found.")
            return
        }

        addAttributes([.font: font, .foregroundColor: textColor], range: range)
    }

    func makeStrikethrough() -> NSMutableAttributedString {
        addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: length))
        return self
    }

    func makeUnderline(_ texts: String...) {
        for text in texts {
            let range = (string as NSString).range(of: text)
            addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: range)
            addAttribute(NSAttributedString.Key.underlineColor, value: UIColor.systemOrange, range: range)
        }
    }
}
