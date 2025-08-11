
import UIKit

extension UIDevice {
    enum ScreenType: String {
        case iPhones_4_4S
        case iPhones_5_5s_5c_SE
        case iPhones_6_6s_7_8
        case iPhones_6Plus_6sPlus_7Plus_8Plus
        case iPhones_X_XS
        case iPhone_XR
        case iPhone_XSMax
        case unknown
    }

    static var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }

    static var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }

    static var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhones_4_4S
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1792:
            return .iPhone_XR
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            return .iPhones_X_XS
        case 2688:
            return .iPhone_XSMax
        default:
            return .unknown
        }
    }

    static func getScreenHeight(screenType: ScreenType) -> CGFloat {
        switch screenType {
        case .iPhones_4_4S:
            return 960
        case .iPhones_5_5s_5c_SE:
            return 1136
        case .iPhones_6_6s_7_8:
            return 1334
        case .iPhone_XR:
            return 1792
        case .iPhones_6Plus_6sPlus_7Plus_8Plus:
            return 2208
        case .iPhones_X_XS:
            return 2436
        case .iPhone_XSMax:
            return 2688
        default:
            return 0
        }
    }

    var hasNotch: Bool {
        let bottom = appWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }

    static var isSmall: Bool {
        return UIDevice.screenType == .iPhones_4_4S || UIDevice.screenType == .iPhones_5_5s_5c_SE || UIDevice.screenType == .iPhones_6_6s_7_8 || UIDevice.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus
    }
}
