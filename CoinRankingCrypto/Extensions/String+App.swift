
import UIKit

extension String {
    func dateFromString() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: self)
    }

    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }

    func image() -> UIImage? {
        let size = CGSize(width: 32, height: 32)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: CGPoint(), size: size)
        UIRectFill(rect)
        (self as NSString).draw(in: rect, withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let finalWidth = boundingBox.width > 150 ? 150 : boundingBox.width
        return ceil(finalWidth)
    }

    func countryFlag() -> String {
        let base = 127_397
        var tempScalarView = String.UnicodeScalarView()
        for i in utf16 {
            if let scalar = UnicodeScalar(base + Int(i)) {
                tempScalarView.append(scalar)
            }
        }
        return String(tempScalarView)
    }

    func formatDescription(key: String) -> String {
        return String(format: NSLocalizedString(key, comment: ""), self)
    }

    func unFormatNumber() -> String {
        return replacingOccurrences(of: Locale.current.groupingSeparator ?? ",", with: "")
    }

    func removeWhiteSpaces() -> String {
        return replacingOccurrences(of: " ", with: "")
    }

    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }

    var htmlToString: String {
        return self.htmlToAttributedString?.string ?? ""
    }

    func capitalizingFirstLetter() -> String {
        return "\(prefix(1).capitalized)\(dropFirst())"
    }

    var hasOnlyNewlineSymbols: Bool {
        return trimmingCharacters(in: CharacterSet.newlines).isEmpty
    }

    func removeCharacters(from forbiddenChars: CharacterSet) -> String {
        let passed = unicodeScalars.filter { !forbiddenChars.contains($0) }
        return String(String.UnicodeScalarView(passed))
    }

    func removeCharacters(from: String) -> String {
        return self.removeCharacters(from: CharacterSet(charactersIn: from))
    }

    func hideCharacters(_ length: Int) -> String {
        let start = count - length
        let from = index(startIndex, offsetBy: start)
        let shownCharacters = self[..<from]
        return "\(String(shownCharacters))\(String(repeating: "*", count: length))"
    }

    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: self)
    }

    func isValidKenyaNumber(_ regex: String) -> Bool {
        let phoneRegEx = regex
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phonePredicate.evaluate(with: self)
    }

    var floatValue: Float {
        return (self as NSString).floatValue
    }

    var intValue: Int {
        return (self as NSString).integerValue
    }

    func currencyFormatting() -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.locale = Locale.current
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 0
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }

    func containsEmoji() -> Bool {
        for scalar in unicodeScalars {
            if !scalar.properties.isEmoji { continue }
            return true
        }

        return false
    }

    func formatPhoneNumberWithX() -> String {
        let cleanedPhoneNumber = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        guard cleanedPhoneNumber.count >= 10 else {
            return self
        }

        let firstTwoDigits = String(cleanedPhoneNumber.prefix(2))
        let lastTwoDigits = String(cleanedPhoneNumber.suffix(2))
        let middleDigits = String(repeating: "*", count: cleanedPhoneNumber.count - 4)
        let formattedPhoneNumber = "\(firstTwoDigits)\(middleDigits)\(lastTwoDigits)"

        return formattedPhoneNumber
    }

    var formattedAsNumber: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2

        if let value = Double(self) {
            return numberFormatter.string(from: NSNumber(value: value)) ?? self
        } else {
            return self
        }
    }

    func obfuscateEmail() -> String {
        let components = split(separator: "@")

        guard components.count == 2 else { return self }

        let username = components[0]
        let domain = components[1]

        guard username.count > 2 else {
            return self
        }

        let obfuscatedUsername = String(username.prefix(2)) + String(repeating: "•", count: username.count - 2)
        let obfuscatedEmail = obfuscatedUsername + "@" + domain
        return obfuscatedEmail
    }
    
    func obfuscatePhoneNumber() -> String {
        let digits = self.filter { $0.isNumber }

        guard digits.count >= 5 else {
            return self
        }

        let prefix = digits.prefix(2)
        let suffix = digits.suffix(3)
        let hiddenCount = digits.count - prefix.count - suffix.count
        let obfuscated = prefix + String(repeating: "*", count: hiddenCount) + String(suffix)

        return String(obfuscated)
    }
}

extension String {
    func splitAtFirstWhitespace() -> String {
        guard let firstSpaceIndex = self.firstIndex(of: " ") else {
            return self
        }

        let firstPart = self[..<firstSpaceIndex]
        let secondPart = self[self.index(after: firstSpaceIndex)...]

        return "\(firstPart)\n\(secondPart)"
    }

    var initials: String {
        return self
            .split(separator: " ")
            .compactMap { $0.first }
            .map { String($0) }
            .joined()
    }
}

extension String {
    func maskAfter(prefixCount: Int, maskCount: Int, maskCharacter: Character = "*") -> String {
        guard !self.isEmpty else { return self }
        guard prefixCount >= 0, maskCount >= 0 else { return self }

        let prefixEnd = min(prefixCount, self.count)
        let start = self.prefix(prefixEnd)

        let remaining = self.dropFirst(prefixEnd)
        let maskLength = min(maskCount, remaining.count)
        let masked = String(repeating: maskCharacter, count: maskLength)

        let suffix = remaining.dropFirst(maskLength)

        return start + masked + suffix
    }
}
