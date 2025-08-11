
import Foundation

extension Date {
    var unixTimeStamp: Int64 {
        return Int64(timeIntervalSince1970 * 1000)
    }

    func getFormattedDate() -> String {
        return "\(getFormattedDay()), \(getFormattedHour())"
    }

    func getFormattedDay() -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(self) {
            return "Today"
        } else if calendar.isDateInYesterday(self) {
            return "Yesterday"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "dd/MM/yy"
            return dateFormatter.string(from: self)
        }
    }

    func getFormattedHour() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self)
    }

    func formateDateNow(format: String = "dd MMM yyyy, hh:mm a") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: self)
    }

    func formateDate(date: Date, format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }

    func getRelativeDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.doesRelativeDateFormatting = true
        return "\(dateFormatter.string(from: Date())), \(Date().getFormattedHour())"
    }

    func isBetweenBankWorkingHrs() -> Bool {
        let date = self
        let calendar = Calendar(identifier: .gregorian)
        guard let startBusinessHr = calendar.date(bySettingHour: 9, minute: 0, second: 0, of: date),
              let endBusinessHr = calendar.date(bySettingHour: 16, minute: 0, second: 0, of: date)
        else { return false }
        return (startBusinessHr ... endBusinessHr).contains(date)
    }

    func isInWeekend() -> Bool {
        Calendar(identifier: .gregorian).isDateInWeekend(self)
    }

    func toString() -> String {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.string(from: self)
    }

    func dateTimestampsInMilliseconds() -> (now: Int, oneYearAgo: Int) {
        let now = Date()
        let oneYearAgo = Calendar.current.date(byAdding: .year, value: -1, to: now)!

        let nowInMilliseconds = Int(now.timeIntervalSince1970 * 1000)
        let oneYearAgoInMilliseconds = Int(oneYearAgo.timeIntervalSince1970 * 1000)

        return (nowInMilliseconds, oneYearAgoInMilliseconds)
    }
}
