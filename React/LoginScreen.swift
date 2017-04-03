//
//  LoginScreen.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 03/04/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Stevia

struct LoginState {
    var email = ""
    var password = ""
    var validateion = LoginValidation.unknown
    var status = LoginStatus.unknown
}

enum LoginValidation {
    case unknown
    case emailTooShort
}


enum LoginStatus {
    case unknown
    case loading
    case success
    case error
}

struct User { }

protocol LoginVCDelegate {
    func didLogin(_ user: User)
    func signUpVCDidSignUpWithUser(_ user: User)
    func pushToSignUp()
}

class LoginScreen: WeactViewController<LoginComponent> {
    
    
    var delegate:LoginVCDelegate?
    
    convenience init() {
        self.init(component:LoginComponent()) //TODO auto with generics?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Se connecter"
        component.signUpTapped = {
            print("HELL YEAH")
            self.delegate?.pushToSignUp()
        }
        
        component.loginTapped = login
        
//        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tap))
//        v.addGestureRecognizer(tapGR)
//    
//        v.emailField.delegate = self
//        v.passwordField.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        component.updateState { $0.status = .unknown }
    }

    func login() {
        let email = component.state.email
        let password = component.state.password
        
        component.updateState { s in
            s.status = .loading
        }
        
        component.updateState { s in
            s.validateion = .emailTooShort
        }
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            self.loginSuceeded()
        }

        // Call roue as usual and refresh state
//        User.login(with: email, password: password)
//            .then(loginSuceeded)
//            .onError(loginFailed)
    }
    
    func loginSuceeded() {
        component.updateState { s in
            s.status = .success
        }
    }
    
    func loginFailed(error: Error) {
        component.updateState { $0.status = .error }
        component.updateState { s in
            s.status = .error
        }
        showLoginErrorPopup()
    }
    
    func showLoginErrorPopup() {
        alert(title: "Erreur", message: "Email ou mot de passe incorrect") { a in
            self.component.updateState { $0.status = .unknown }
        }
    }
}



// TODO bind to state. email  textChanged
// TODO Keep Field states by default?

class LoginComponent: Component {
    
    var state = LoginState()
    
    var signUpTapped = { }
    var loginTapped = { }
    
    func render(state: LoginState) -> Renderable {
        return View(layout: { $0.fillContainer() }, [
            VerticalStack(style: { (stack:UIStackView) in
                stack.spacing = 8
            }, layout: { |-$0-|.top(80) }, [
                Field("Email", wording:state.email, textChanged: { t in
                    self.updateState { s in
                        s.email = t
                    }
                }, style: { f in
                    self.email(f)
                    
                    if state.validateion == .emailTooShort {
                        f.backgroundColor = .red
                    }
                    
                }, layout: { $0.height(80) }),
                Field("Password", wording:state.password, textChanged: { t in
                    self.updateState { s in
                        s.password = t
                    }
                }, style: password, layout: { $0.height(80) }),
            ]),
            VerticalStack(layout: { |$0|.bottom(0) }, [
                Button("Vous n'avez pas de compte Yummypets ?", tap: signUpTapped, style: signUpButton, layout: { $0.height(80) }),
                Button(buttonTextForState(state.status), tap: loginTapped, style: { b in
                    let status = state.status
                    b.backgroundColor = .lightGray
                    b.isEnabled = status == .unknown || status == .error
                    b.alpha = (status == .loading) ? 0.5 : 1
                    b.backgroundColor = self.buttonColorForState(status)
                }, layout: { $0.height(80) })
            ])
        ])
    }
    
//    func navigateToSignUp() {
//        print("navigateToSignUp")
//    }
    
    // Sync state with Field
    func emailChanged(email:String) {
        state.email = email
        
        // validate?
    }
    
    func signupTapped() {
        updateState { state in
            state.status = .error
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
    
    var email = { (f:UITextField) in
        f.borderStyle = .roundedRect
        f.autocorrectionType = .no
        f.keyboardType = .emailAddress
        f.autocapitalizationType = .none
        f.font = UIFont(name: "HelveticaNeue-Light", size: 26)
        f.returnKeyType = .next
    }
    
    var password = { (f:UITextField) in
        f.borderStyle = .roundedRect
        f.font = UIFont(name: "HelveticaNeue-Light", size: 26)
        f.isSecureTextEntry = true
        f.returnKeyType = .done
    }
    
    var signUpButton = { (b:UIButton) in
        b.setTitleColor(UIColor(red: 0.6588, green: 0.702, blue: 0.1725, alpha: 1.0), for: .normal)
        b.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        b.titleLabel?.attributedText = NSAttributedString(string: b.titleLabel!.text!, attributes: [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
    }
}

//TODO login button up with KB + kb next

//class LoginVC: UIViewController, UITextFieldDelegate {
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        //        v.emailField.becomeFirstResponder()
//    }
//    
//    func tap() {
//        v.endEditing(true)
//    }
//    
//    func ok() {
//        v.endEditing(true)
//    }

//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(ok))
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        navigationItem.rightBarButtonItem = nil
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == v.emailField {
//            v.passwordField.becomeFirstResponder()
//        } else if textField == v.passwordField {
//            v.endEditing(true)
//            login()
//        }
//        return true
//    }
//}


extension UIViewController {
    
    func alert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        present(alert, animated: true, completion: nil)
    }
}

