//
//  IGText.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation

class IGKey {

    static let User                               = "User"
    static let SignInStatus                       = "isSignIn"
    static let AppOpenStatus                      = "isAppOpen"
    static let AppIntroStatus                     = "isAppIntro"
}

class ConstantString {

    static let ok                = "OK"
    static let yes               = "Yes"
    static let no                = "No"
    static let cancel            = "Cancel"
    static let done              = "Done"
    static let error             = "Error"
    static let delete            = "Delete"
    static let remove            = "Remove"    
    static let exit              = "Exit"
    static let takePhoto         = "Take a Photo"
    static let chooseFromGallary = "Choose From Gallery"
    static let signout           = "Sign out"
    static let signin            = "Sign in"
    static let openSettings      = "Open Settings"
}

class AlertMessage {

    static let emailAlert              = "Please enter E-mail"
    static let emailValidAlert         = "Please enter valid E-mail"

    static let passwordAlert           = "Please enter Password"
    static let passwordValidAlert      = "Please enter valid Password"
    static let passwordRangeAlert      = "Passwords must be at least 8-16 characters in length."

    static let oldPasswordAlert        = "Please enter old Password"
    static let newPasswordAlert        = "Please enter new Password"
    static let confirmPasswordAlert    = "Please enter confirm Password"

    static let passwordNotSameAlert    = "Both Password doesn't match"

    static let phoneNumberAlert        = "Enter your mobile number below so we can vaildate your number"
    static let phoneNumberValidAlert   = "Enter your mobile number below so we can vaildate your number"

    static let verificationCode        = "Please enter verification code"
    static let verificationCodeValid   = "Please enter valid verification code"
    static let verificationCodeNotSame = "Verification code doesn't match"

    static let cameraError             = "Device has no camera"
    static let cameraRequestError      = "Please enable camera permissions in settings"

    static let askSignout              = "Are you sure you want to signout from BaseProject?"
    static let agreeTermsConditions    = "Please agree terms and conditions"
    static let signupSuccessMessage    = "Signup successfully, You can Sign In now."

    static let profileImageAlert       = "Please select profile image"
    static let birthdateAlert          = "Please select birthdate"
    static let profileUpdateAlert      = "Profile updated successfully"
    static let firstNameAlert          = "Enter first name"
    static let lastNameAlert           = "Enter last name"
    static let completeProfielAlert    = "Please complete your profile"

    static let noLocationAlert         = "No location found!"
    static let defaultError            = "Something went wrong, Please try again"
}

class PlaceHolderText {

    static let email               = "E-mail"
    static let password            = "Password"
    static let confirmPassword     = "Confirm Password"
    static let phoneNumber         = "Phone Number"
    static let oldPassword         = "Old Password"
    static let secretPin           = "Secret Pin"

    static let newPassword         = "New Password"
    static let confirmNewPassword  = "Confirm New Password"
    
    static let firstName           = "First Name"
    static let lastName            = "Last Name"
    static let selectDate          = "Select Date"
    static let selectCountry       = "Select Country"
    static let groupName           = "Group Name"
    
    static let departureAirport    = "Enter the Departure Airport"
    static let destinationAirport  = "Enter the Destination Airport "
    static let hotelname           = "Hotel name"
    static let mobileNumber        = "Mobile Number"
    
    static let cardHolderName      = "Card Holder Name"
    static let cardnumber          = "Card Number"
    static let cardCVV             = "CVV"
    static let cardExpDate         = "Expiration Date"
}

class CellType {
    
    static let GroupCell                         = "IGGroupCell"
}


class IGNotificationName {
    
//    static let ContactChange       = NSNotification.Name.CNContactStoreDidChange
    static let ProfileSwitch       = NSNotification.Name.init("ProfileSwitch")
    static let CreateNewGroup      = NSNotification.Name.init("CreateNewGroup")
    static let DeleteGroup         = NSNotification.Name.init("DeleteGroup")
    static let UpdateGroupMember   = NSNotification.Name.init("UpdateGroupMember")
    static let RefreshGroup        = NSNotification.Name.init("RefreshGroup")
}




