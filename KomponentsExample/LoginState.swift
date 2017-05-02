//
//  LoginState.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 24/04/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

struct LoginState {
    var email = "" { didSet { validate() } }
    var password = "" { didSet { validate() } }
    var status = LoginStatus.unknown
    var emailValid = FieldValidationStatus.unknown
    var passwordValid = FieldValidationStatus.unknown
    func isFormvalid() -> Bool { return emailValid == . valid && passwordValid == .valid }
    var emailFieldFocused = true
    var passwordFieldFocused = false
    private mutating func validate() {
        emailValid = email.contains("@") ? .valid : .invalid
        passwordValid = password.characters.count >= 6 ? .valid : .invalid
        status = .unknown
    }
}
enum FieldValidationStatus {
    case unknown
    case valid
    case invalid
}

enum LoginStatus {
    case unknown
    case loading
    case success
    case error
}
