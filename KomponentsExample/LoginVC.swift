//
//  LoginScreen.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 03/04/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Stevia
import UIKit
import Komponents

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
// Cannot inject generic comp?? (injection$Xcode?
// Functional Component Example

func SignupButton() -> Button {
    return SignupButton(text: "Hello")
    // TODO hwo to make it so that we can add functionalities?? ex: overide style, layout etc
}

// Functional Component with props Example

func SignupButton(text: String) -> Button {
    return Button(text, props: { p in /*$0.backgroundColor = .red*/ }, layout: Layout().height(80))
    // TODO hwo to make it so that we can add functionalities?? ex: overide style, layout etc
}

class LoginVC: UIViewController, Component {
    
    var state = LoginState()
    
    override func loadView() { loadComponent() }
    
    // MARK - View
    
    func render() -> Tree {
        title = "Login Screen"
        return View([
            VerticalStack(props: { $0.spacing = 8 },
                          layout: Layout().fillHorizontally().top(80), [
                Field("Email",
                      text: state.email,
                      textChanged: emailChanged,
//                      style: emailStyle,
                      layout: Layout().height(80)
                ),
                Field("Password",
                      text: state.password,
                      textChanged: passwordChanged,
//                      style: passwordStyle,
                      layout: Layout().height(80)
                )
                ]),
            VerticalStack(layout: Layout().fillHorizontally().bottom(0), [
                    Button("Vous n'avez pas de compte ?",
//                       style: signUpButtonStyle,
                       layout: Layout().height(80)
                ),
                Button(buttonTextForState(state.status),
                       tap: login,
//                       style: loginButtonStyle,
                       layout: Layout().height(80)
                )
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
//        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
//            if self.state.email == "sacha" {
//                self.updateState { $0.status = .success }
//            } else {
//                self.updateState { $0.status = .error }
//            }
//        }
    }
    
    // MARK - Styles
    
    func inputStyle(_ f: UITextField) {
        f.borderStyle = .roundedRect
        f.font = UIFont(name: "HelveticaNeue-Light", size: 26)
        f.layer.borderWidth = 1
    }
    
    func emailStyle(f: UITextField) {
        inputStyle(f)
        f.autocorrectionType = .no
        f.keyboardType = .emailAddress
        f.autocapitalizationType = .none
        f.returnKeyType = .next
        f.layer.borderColor = state.emailValid == .invalid ? UIColor.red.cgColor : UIColor.green.cgColor
        if state.emailFieldFocused {
            f.becomeFirstResponder()
        }
    }
    
    func passwordStyle(f: UITextField) {
        inputStyle(f)
//        f.isSecureTextEntry = true // Bug text reset everytime :/
        f.returnKeyType = .done
        f.layer.borderColor = state.passwordValid == .invalid ? UIColor.red.cgColor : UIColor.green.cgColor
        if state.passwordFieldFocused {
            f.becomeFirstResponder()
        }
    }
    
    func signUpButtonStyle(b: UIButton) {
        b.setTitleColor(UIColor(red: 0.6588, green: 0.702, blue: 0.1725, alpha: 1.0), for: .normal)
        b.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        if let text = b.titleLabel?.text {
        b.titleLabel?.attributedText = NSAttributedString(string: text,
                                                          attributes: [
                                                            NSUnderlineStyleAttributeName:
                                                            NSUnderlineStyle.styleSingle.rawValue
            ])
        }
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
