
import Foundation
import libPhoneNumber_iOS

extension NBPhoneNumberUtil {
    func isPhoneLengthValid(_ phone: String, _ regionCode: String) -> Bool {
        return phone.count <= maximumPhoneLength(regionCode)
    }

    func maximumPhoneLength(_ regionCode: String) -> Int {
        return getExampleNumber(regionCode).count
    }

    func formatPhoneNumberToMaxLength(_ phone: String, _ regionCode: String) -> String {
        var formattedPhone = phone
        let maximumPhoneLength = self.maximumPhoneLength(regionCode)
        if formattedPhone.count > maximumPhoneLength {
            let index = formattedPhone.index(formattedPhone.startIndex, offsetBy: maximumPhoneLength)
            formattedPhone = String(formattedPhone[..<index])
        }
        return formattedPhone
    }

    func getExampleNumber(_ regionCode: String) -> String {
        do {
            let exampleNumber = try getExampleNumber(forType: regionCode, type: .MOBILE).nationalNumber
            return (exampleNumber?.stringValue ?? "")
        } catch {
            sPrint(error)
            return ""
        }
    }

    func getCountryExtensionCode(_ regionCode: String) -> String {
        return getCountryCode(forRegion: regionCode).stringValue
    }

    func phoneNumberPlaceHolder(_ regionCode: String) -> String {
        var phoneHint: String?
        let extensionCode = getCountryExtensionCode(regionCode)
        do {
            let sampleNumber = try getExampleNumber(forType: regionCode, type: .MOBILE).nationalNumber
            let x = try parse(sampleNumber?.stringValue ?? "", defaultRegion: regionCode)
            phoneHint = try format(x, numberFormat: .E164)
        } catch {
            sPrint(error)
        }
        return phoneHint?.replacingOccurrences(of: "+\(extensionCode)", with: "") ?? ""
    }

    func cleanPhoneNumber(_ phoneNumber: String) -> String {
        var phone = phoneNumber
        do {
            let nbPhone = try parse(withPhoneCarrierRegion: phoneNumber)
            if let regionCode = getRegionCode(for: nbPhone), let countryCode = getCountryCode(forRegion: regionCode) as? Int {
                let countryCodeString = String(countryCode)
                phone = phone.replacingOccurrences(of: "+\(countryCodeString)", with: "")
                phone = phone.hasPrefix(countryCodeString) ? String(phone.dropFirst(countryCodeString.count)) : phone
            }
        } catch {}
        phone = phone.first == "0" ? String(phone.dropFirst()) : phone
        return phone
    }

    func cleanPhoneNumberSTK(_ phoneNumber: String) -> String {
        var phone = phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)

        if phone.hasPrefix("+") {
            phone.removeFirst()
        }

        if phone.hasPrefix("254") {
            phone.removeFirst(3)
            phone = "0" + phone
        }

        else if phone.hasPrefix("0") {}

        else {
            phone = "0" + phone
        }

        return phone
    }

    func formatPhoneNumber(_ phoneNumber: String) -> String {
        var phone = phoneNumber
        do {
            let nbPhone = try parse(withPhoneCarrierRegion: phoneNumber)
            if let regionCode = getRegionCode(for: nbPhone), let countryCode = getCountryCode(forRegion: regionCode) as? Int {
                let countryCodeString = String(countryCode)
                phone = phone.replacingOccurrences(of: "+\(countryCodeString)", with: "0")
                phone = phone.hasPrefix(countryCodeString) ? String(phone.dropFirst(countryCodeString.count)) : phone
            }
        } catch {}
        return phone
    }
}
