//
//  LoginView.swift
//  CryptoProlect
//
//  Created by Ahmed on 4/8/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit
import TinyConstraints

class LoginView: UIViewController {
    
    var loginViewModel: LoginViewModel!
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var activityIndicator: SpinnerViewController = {
        let indic = SpinnerViewController()
        indic.modalPresentationStyle = .overCurrentContext
        return indic
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var segment: UISegmentedControl = {
        let segmentItems = ["Sign in", "Sign Up"]
        let segment = UISegmentedControl(items: segmentItems)
        segment.addTarget(self, action: #selector(segmentControl), for: .valueChanged)
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    lazy var formView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var wellComeLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Wellcom to High Secure Team Chat"
        lbl.font = UIFont.systemFont(ofSize: 28.0)
        lbl.textColor = .darkGray
        lbl.numberOfLines = 2
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var usernameTF: ReusableTextField = {
        let rtf = ReusableTextField()
        rtf.textField.placeholder = "Enter username"
        rtf.imgView.image = #imageLiteral(resourceName: "Linear_user")
        rtf.isHidden = true
        return rtf
    }()
    
    lazy var emailTF: ReusableTextField = {
        let rtf = ReusableTextField()
        rtf.textField.placeholder = "Enter email"
        rtf.imgView.image = #imageLiteral(resourceName: "Typ_mail")
        return rtf
    }()
    
    lazy var passwordTF: ReusableTextField = {
        let rtf = ReusableTextField()
        rtf.textField.placeholder = "Enter password"
        rtf.imgView.image = #imageLiteral(resourceName: "Linear_lock")
        rtf.textField.isSecureTextEntry = true
        return rtf
    }()
    
    lazy var signInCons = formView.stack([emailTF, passwordTF], spacing: 12)
    
    lazy var signUpCons = formView.stack([usernameTF, emailTF, passwordTF], spacing: 12)
    
    lazy var signInBtnCons = submitView.stack([signinBtn])

    lazy var signUpBtnCons = submitView.stack([signupBtn])
    
    lazy var submitView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var signinBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.layer.borderWidth = 0.4
        btn.setTitleColor(.darkGray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(signInPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var signupBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("SignUp", for: .normal)
        btn.layer.borderWidth = 0.4
        btn.setTitleColor(.darkGray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        // Do any additional setup after loading the view.
        loginViewModel = LoginViewModel()
        loginViewModel.delegate = self
        self.setupViews()
    }
    
    @objc private func segmentControl(){
        switch segment.selectedSegmentIndex {
        case 0:
            // sign in view
            signUpCons.deActivate()
            signUpCons.deActivate()
            signInCons.activate()
            signInBtnCons.activate()
            usernameTF.isHidden = true
            signupBtn.isHidden = true
            signinBtn.isHidden = false
            break
        case 1:
            // sign up view
            signInCons.deActivate()
            signInBtnCons.deActivate()
            signUpCons.activate()
            signUpBtnCons.activate()
            usernameTF.isHidden = false
            signinBtn.isHidden = true
            signupBtn.isHidden = false
            break
        default:
            break
        }
    }
    
    @objc private func signInPressed(){
        let email = emailTF.textField.text
        let passowrd = passwordTF.textField.text
        self.loginViewModel.userSignIn(email: email, password: passowrd)
    }
    
    @objc private func signUpPressed(){
        let email = emailTF.textField.text
        let username = usernameTF.textField.text
        let passowrd = passwordTF.textField.text
        
        self.loginViewModel.userSignUp(username: username, email: email, password: passowrd)
    }
    
    fileprivate func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(segment)
//        containerView.addSubview(activityIndicator)
        containerView.addSubview(formView)
        containerView.addSubview(wellComeLbl)
        containerView.addSubview(usernameTF)
        containerView.addSubview(emailTF)
        containerView.addSubview(passwordTF)
        containerView.addSubview(submitView)
        submitView.addSubview(signinBtn)
        submitView.addSubview(signupBtn)
        
        scrollView.edgesToSuperview(usingSafeArea: true)
        
        containerView.edgesToSuperview(excluding: .bottom)
        containerView.width(self.view.frame.size.width)
        
        
        
        wellComeLbl.edgesToSuperview(excluding: .bottom,
                                 insets: TinyEdgeInsets(top: 16, left: 16, bottom: 0, right: 16),
                                 usingSafeArea: true)
        
        segment.topToBottom(of: wellComeLbl, offset: 16)
        segment.leadingToSuperview(offset: 32, usingSafeArea: true)
        segment.trailingToSuperview(offset: 32, usingSafeArea: true)
        
        formView.topToBottom(of: segment, offset: 32)
        formView.leadingToSuperview(offset: 16)
        formView.trailingToSuperview(offset: 16)
        
        let tfHeight: CGFloat = 55.0
        usernameTF.height(tfHeight)
        emailTF.height(tfHeight)
        passwordTF.height(tfHeight)
        
//        formView.stack([usernameTF, passwordTF], spacing: 12)
//        segmentControl()
        signInCons.activate()
        signInBtnCons.activate()
        
        submitView.topToBottom(of: formView, offset: 32)
        submitView.leadingToSuperview(offset: 32)
        submitView.trailingToSuperview(offset: 32)
        
        signinBtn.height(45)
        signupBtn.height(45)
        submitView.stack([signinBtn, signupBtn], spacing: 8)
        submitView.bottomToSuperview(offset: -32.0)
        
        
    }

}

extension LoginView: LoginViewModelDelegate {
    func startSign() {
        self.present(activityIndicator, animated: true)
        self.view.endEditing(true)
    }
    
    func endSign(success: Bool, message: String) {
        activityIndicator.dismiss(animated: true) {
            if success {
                self.showAlert(msg: message) {
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                self.showAlert(msg: message, nil)
            }
        }
        
    }
    
    
}
