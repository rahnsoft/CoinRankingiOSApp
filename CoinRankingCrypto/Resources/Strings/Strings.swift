
import Foundation

enum Strings: String {
    // MARK: Common

    case commonTitle = "Common_title"
    case commonHome = "Common_Home"
    case commonSave = "Common_Save"
    case commonOkay = "Common_Okay"
    case commonCancel = "Common_Cancel"
    case commonGotIt = "Common_GotIt"
    case commonContinue = "Common_Continue"
    case commonTryAgain = "Common_TryAgain"
    case commonTryAgainCount = "Common_TryAgain_Count"
    case commonTryAgainLater = "Common_TryAgainLater"
    case commonRetry = "Common_Retry"
    case commonTotal = "Common_Total"
    case commonInfo = "Common_Info"
    case commonProceed = "Common_Proceed"
    case commonVerify = "Common_Verify"
    case commonSendAgain = "Common_Send_Again"
    case commonTermsAndConditions = "Common_Terms_Conditions"
    case commonName = "Common_Name"
    case commonEmail = "Common_email"
    case commonSomethingWentWrong = "Common_something_went_wrong"
    case commonWeHitAsnag = "Common_we_hit_a_snag"
    case commonYouVeBeenLoggedOut = "Common_You_ve_been_logged_out"
    case commonSignedOut = "Common_signed_out"
    case favourites = "Common_favourites"
    case skip = "Common_skip"

    // MARK: Errors

    case commonGeneralError = "Common_GeneralError"
    case commonInternetError = "Common_InternetError"
    case commonInternetErrorDesc = "Common_InternetError_Desc"
    case invalidPhoneNumberError = "Invalid_PhoneNumber"
    case invalidMeterNumberError = "Invalid_Bill_Number"
    case commonCheckInternet = "Common_check_internet"

    // MARK: Get Started

    case getStartedOneTitle = "Get_Started_one_title"
    case getStartedOneSubTitle = "Get_Started_one_subTitle"
    case getStartedTwoTitle = "Get_Started_two_title"
    case getStartedTwoSubTitle = "Get_Started_tow_subTitle"
    case getStartedThreeTitle = "Get_Started_three_title"
    case getStartedThreeSubTitle = "Get_Started_three_subTitle"
    case getStarted = "Get_Started"
    case getStartedExcl = "Get_Started!"

    // MARK: Auth

    case authSignUp = "Auth_Sign_Up"
    case authYourName = "Auth_Your_name"
    case authFirstName = "Auth_First_name"
    case authLastName = "Auth_Last_name"
    case authEmailAddress = "Auth_Email_address"
    case authSignInHere = "Auth_Sign_In_Here"
    case authSignUpDesc = "Auth_Sign_Up_Desc"
    case authSignInHereDesc = "Auth_Sign_In_Here_Desc"
    case authSignUpPlaceHolder = "Auth_Sign_Up_PlaceHolder"
    case authPhoneNumber = "Auth_Phone_Number"
    case authVerifyPhoneNumber = "Auth_Verify_phone_number"
    case authEnterCodeSentTo = "Auth_Enter_Code_Sent_To"
    case authDidNotReceiveCodeSendAgainIn = "Auth_Did_Not_Receive_Code_Send_Again_In"
    case authDidNotReceiveCodeSendAgain = "Auth_Did_Not_Receive_Code_Send_Again"
    case authWrongOtpCode = "Auth_Wrong_Otp_Code"
    case authSetPin = "Auth_Set_Up_Pin"
    case authEnter4DigitsPin = "Auth_Enter_4_Digits_Pin"
    case authPin = "Auth_Pin"
    case authConfirmPin = "Auth_Confirm_Pin"
    case authAcknowledgeTermsConditions = "Auth_Acknowledge_Terms_Conditions"
    case authSignIn = "Auth_Sign_In"
    case authSignInToContinue = "Auth_Sign_In_To_Continue"
    case authMaybeLater = "Auth_Maybe_later"
    case authSignInDesc = "Auth_Sign_In_Desc"
    case authPinPassword = "Auth_Pin_Password"
    case authDontHaveAccount = "Auth_Dont_Have_Account"
    case authDoHaveAccount = "Auth_Do_Have_Account"
    case authSignUpHere = "Auth_Sign_Up_Here"
    case authWelcomeTo = "Auth_Welcome_To"
    case authSearch = "Auth_Search"
    case authSetPassword = "Auth_Set_password"
    case authResetPassword = "Auth_Reset_password"
    case authPassword = "Auth_Password"
    case authConfirmPassword = "Auth_Confirm_password"
    case authUsername = "Auth_Username"
    case authForgotPassword = "Auth_Forgot_password"
    case authAccountRecovery = "Auth_Account_recovery"
    case authAccountRecoveryDesc = "Auth_Account_recovery_desc"
    case authAccountRecoveryEmail = "Auth_Account_recovery_email"
    case authAccountRecoveryError = "Auth_Account_recovery_error"
    case authEnterCode = "Auth_Enter_code"
    case authPasswordResetSuccess = "Auth_Password_reset_success"
    case authPasswordResetSuccessDesc = "Auth_Password_reset_success_desc"
    case authGoToLogin = "Auth_Go_To_Login"
    case authBioLogin = "Auth_Bio_Login"
    case authVerifyIdentity = "Auth_Verify_Identity"
    case authVerifyIdentityUsing = "Auth_Verify_Identity_Using"
    case authFaceId = "Auth_Face_Id"
    case authFingerprint = "Auth_Fingerprint"
    case authEnableFaceId = "Auth_Enable_Face_Id"
    case authUseBiometricSubTitle = "Auth_Use_Biometric_subTitle"
    case authGoToSettings = "Auth_Go_To_Settings"
    case authConfirmDetails = "Auth_confirm_details"
    case accountFoundSuccessfully = "Account_found_successfully"
    case accountFoundSuccessfullyDesc = "Account_found_successfully_desc"
    case createPasswordContinue = "Create_password_continue"
    case createPassword = "Create_password"
    case accountNotFound = "Account_not_found"
    case weCouldntFindAccount = "We_couldnt_find_account"
    case weCouldntFindAccountDesc = "We_couldnt_find_account_desc"
    case weCouldntFindAccountTitleDesc = "We_couldnt_find_account_title_desc"
    case setUpMyAccount = "Set_up_my_account"
    case setUpYourPassword = "Set_up_your_password"

    // MARK: OTP

    case welcomeOnboard = "Welcome_Onboard"
    case weSentOtp = "We_sent_otp"
    case authSkip = "Auth_Skip"

    // MARK: HOME

    case commonMarkets = "Common_markets"
    case favoriteSaved = "Favorite_saved"

    func localized() -> String {
        return NSLocalizedString(rawValue, comment: "")
    }

    func localized(with arg: String) -> String {
        return String.localizedStringWithFormat(localized(), arg)
    }

    func localized(with arg: Int) -> String {
        return String.localizedStringWithFormat(localized(), arg)
    }

    func localized(with arg: Double) -> String {
        return String.localizedStringWithFormat(localized(), arg)
    }

    func localized(with args: [CVarArg]) -> String {
        return String(format: localized(), args)
    }

    func localized(with args: CVarArg...) -> String {
        return String(format: localized(), args)
    }
}
