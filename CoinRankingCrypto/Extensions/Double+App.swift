
import Foundation

extension Double {
    var cleanDouble: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }

    func formattedNumber() -> String {
        return NSNumber(value: self).formattedNumber()
    }

    func formattedNumberAbs() -> String {
        return NSNumber(value: abs(self)).formattedNumber()
    }

    func formattedPercentage(_ decimalPlaces: Int = 2) -> String {
        return String(format: "%.\(decimalPlaces)f%%", self * 100)
    }
}

extension Int {
    func formattedNumber() -> String {
        return NSNumber(value: self).formattedNumber()
    }

    func formattedNumberAbs() -> String {
        return NSNumber(value: abs(self)).formattedNumber()
    }
}
