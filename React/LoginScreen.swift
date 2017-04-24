//
//  LoginScreen.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 03/04/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Stevia

// TODO bind to state. email  textChanged
// TODO Keep Field states by default?
// TODO exaple navigation
// TODO how to use ViewController title as used in navigation Stacks?
// TODO handle a tap gesure regognizer on a view?
// Delegate pattern needed ?
// Validate field?
// TODO how to show an alert?
// TOdo how to show an action sheet?
// TODO keep field selection state internally?
// email return Keyboard -> select pass.
// Toggle Ok button in nav bar? UIBarButtonItem
// dismiss keyboard

// layout externally

// MARK - State

struct LoginState {
    var email = "" { didSet { validate() } }
    var password = "" { didSet { validate() } }
    var status = LoginStatus.unknown
    var emailValid = FieldValidationStatus.unknown
    var passwordValid = FieldValidationStatus.unknown
    func isFormvalid() -> Bool  { return emailValid == . valid && passwordValid == .valid }
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

// MARK - Component

class LoginComponent: CustomComponent<LoginState> {
    
    override func initialState() -> LoginState! { return LoginState() }
    
    // MARK - View
    
    override func render(state: LoginState) -> Node {
        return View(layout: { $0.fillContainer() }, [
            VerticalStack(style: { (stack:UIStackView) in stack.spacing = 8 }, layout: { |-$0-|.top(80) }, [
                Field("Email", wording: state.email, textChanged: emailChanged, style: emailStyle, layout: { $0.height(80) }),
                Field("Password", wording: state.password, textChanged: passwordChanged, style: passwordStyle, layout: { $0.height(80) }),
            ]),
            VerticalStack(layout: { |$0|.bottom(0) }, [
                Button("Vous n'avez pas de compte Yummypets ?", style: signUpButtonStyle, layout: { $0.height(80) }),
                Button(buttonTextForState(state.status), tap: login, style: loginButtonStyle, layout: { $0.height(80) })
            ])
        ])
    }
    
    // MARK - Events
    
    // TODO find a way to plug directyl fields on String state properties.
    // so that we don't have to write this :)
    
    func emailChanged(email: String) {
        updateState {
            $0.email = email
            $0.emailFieldFocused = true
            $0.passwordFieldFocused = false
        }
    }
    
    func passwordChanged(pass: String) {
        updateState {
            $0.password = pass
            $0.emailFieldFocused = false
            $0.passwordFieldFocused = true
        }
    }
    
    func login() {
        updateState { $0.status = .loading }
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            if self.state.email == "sacha" {
                self.updateState { $0.status = .success }
            } else {
                self.updateState { $0.status = .error }
            }
        }
    }
    
    // MARK - Styles
    
    func emailStyle(f: UITextField) {
        f.borderStyle = .roundedRect
        f.autocorrectionType = .no
        f.keyboardType = .emailAddress
        f.autocapitalizationType = .none
        f.font = UIFont(name: "HelveticaNeue-Light", size: 26)
        f.returnKeyType = .next
        f.layer.borderColor = state.emailValid == .invalid ? UIColor.red.cgColor : UIColor.green.cgColor
        f.layer.borderWidth = 1
        if state.emailFieldFocused {
            f.becomeFirstResponder()
        }
    }
    
    func passwordStyle(f: UITextField) {
        f.borderStyle = .roundedRect
        f.font = UIFont(name: "HelveticaNeue-Light", size: 26)
//        f.isSecureTextEntry = true // Bug text reset everytime :/
        f.returnKeyType = .done
        f.layer.borderColor = state.passwordValid == .invalid ? UIColor.red.cgColor : UIColor.green.cgColor
        f.layer.borderWidth = 1
        if state.passwordFieldFocused {
            f.becomeFirstResponder()
        }
    }
    
    func signUpButtonStyle(b: UIButton) {
        b.setTitleColor(UIColor(red: 0.6588, green: 0.702, blue: 0.1725, alpha: 1.0), for: .normal)
        b.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        b.titleLabel?.attributedText = NSAttributedString(string: b.titleLabel!.text!,
                                                          attributes: [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
    }
    
    func loginButtonStyle(b: UIButton) {
        let status = state.status
        b.backgroundColor = .lightGray
        b.isEnabled = status == .unknown || status == .error
        b.alpha = (status == .loading) ? 0.5 : 1
        b.backgroundColor = self.buttonColorForState(status)
        b.isEnabled = state.isFormvalid()
    }
    
    // MARK - Helpers
    
    func buttonColorForState(_ status: LoginStatus) -> UIColor {
        switch status {
        case .unknown, .loading:
            return .lightGray
        case .success:
            return .green
        case .error:
            return .red
        }
    }
    
    func buttonTextForState(_ status: LoginStatus) -> String {
        switch status {
        case .unknown:
            return "Se connecter"
        case .loading:
            return "Connexion..."
        case .success:
            return "Connecté"
        case .error:
            return "Erreur"
        }
    }
}
