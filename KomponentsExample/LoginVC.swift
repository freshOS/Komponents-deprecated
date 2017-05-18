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

func SignupButton() -> Button {
    return SignupButton(text: "Hello")
    // TODO hwo to make it so that we can add functionalities?? ex: overide style, layout etc
}

// Functional Component with props Example

func SignupButton(text: String) -> Button {
    return Button(text, props: { p in /*$0.backgroundColor = .red*/ }, layout: Layout().height(80))
}

class LoginVC: UIViewController, Component {
    
    var reactEngine: KomponentsEngine?
    
    var state = LoginState()
    
    override func loadView() { loadComponent() }
    
    // MARK - View
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login Screen"
    }
    
    var emailFieldRef = UITextField()
    var passwordFieldRef = UITextField()
    var buttonRef = UIButton()
    
    func render() -> Tree {
        
    
        return View([
            VerticalStack(props: { $0.spacing = 8 },
                          layout: Layout().fillHorizontally().top(80), [
                Field("Email",
                      text: state.email,
                      textChanged: { [weak self] email in self?.updateState { $0.email = email } } ,
//                      style: emailStyle,
                      layout: Layout().height(80),
                      ref : &emailFieldRef
                ),
                Field("Password",
                      text: state.password,
                      textChanged: { [weak self] pass in self?.updateState { $0.password = pass } } ,
//                      style: passwordStyle,
                      layout: Layout().height(80),
                      ref : &passwordFieldRef
                )
                ]),
            VerticalStack(layout: Layout().fillHorizontally().bottom(0), [
                Button(buttonTextForState(state.status),
                       tap: { [weak self] in self?.login() },
//                       style: loginButtonStyle,
                       layout: Layout().height(80),
                        ref : &buttonRef
                )
            ])
        ])
    }
    
//    func bindTo(property:UnsafeMutablePointer<String>) {
//        self.text = property.pointee // apply text.
//        
////        { [weak self] email in self?.updateState { property = email }
//    }
    
    func didRender() {
        applyStyles()
    }
    
    func didUpdateState() {
        applyStyles()
    }
    
    func applyStyles() {
        emailStyle(f: emailFieldRef)
        passwordStyle(f: passwordFieldRef)
        loginButtonStyle(b: buttonRef)
    }
    

    
    func login() {
        updateState { $0.status = .loading }
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            if self.state.email == "sachadso@gmail.com" {
                self.updateState { $0.status = .success }
            } else {
                self.updateState { $0.status = .error }
            }
        }
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
    }
    
    func passwordStyle(f: UITextField) {
        inputStyle(f)
        f.isSecureTextEntry = true // Bug text reset everytime? :/
        f.returnKeyType = .done
        f.layer.borderColor = state.passwordValid == .invalid ? UIColor.red.cgColor : UIColor.green.cgColor
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
