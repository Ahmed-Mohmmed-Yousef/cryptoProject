//
//  ViewController.swift
//  CryptoProlect
//
//  Created by Ahmed on 4/5/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit
import FirebaseAuth
import TinyConstraints

class RootViewController: UIViewController {
    
    var rootVM: RootVM!
    
    lazy var activityIndicator: SpinnerViewController = {
        let indic = SpinnerViewController()
        indic.modalPresentationStyle = .overCurrentContext
        return indic
    }()
    
    lazy var enterLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Write your message"
        lbl.font = UIFont.systemFont(ofSize: 20.0)
        lbl.textColor = .darkGray
        return lbl
    }()
    
    lazy var messageView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 18)
        tv.tintColor = .darkGray
        return tv
    }()
    
    lazy var passwordTF: ReusableTextField = {
        let rtf = ReusableTextField()
        rtf.textField.placeholder = "Enter password"
        rtf.imgView.image = #imageLiteral(resourceName: "Linear_lock")
        rtf.textField.isSecureTextEntry = true
        return rtf
    }()

    lazy var segment: UISegmentedControl = {
        let segment = UISegmentedControl(items: EncryptionType.items)
//        segment.addTarget(self, action: #selector(segmentControl), for: .valueChanged)
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    lazy var sendBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Send", for: .normal)
        btn.layer.borderWidth = 0.4
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        btn.backgroundColor = .lightGray
        btn.addTarget(self, action: #selector(sendBtnPressed), for: .touchUpInside)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        self.rootVM = RootVM()
        self.rootVM.delegate = self
        
        self.setupNavBar()
        self.setupViews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser == nil {
            let loginVC = LoginView()
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
        }
    }
    
    fileprivate func setupNavBar(){
        navigationItem.title = "Secure Message Pass"
        let myMessageBarBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "SF_text_bubble"), style: .plain, target: self, action: #selector(gotoMyMessages))
        let signOutBarBtn = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(signOutPressed))
        navigationItem.setLeftBarButton(myMessageBarBtn, animated: false)
        navigationItem.setRightBarButton(signOutBarBtn, animated: false)
        
    }
    
    @objc private func signOutPressed(){
        rootVM.signOut()
    }
    
    @objc private func gotoMyMessages(){
        let msgVC = MyMessagesVC()
        rootVM.fetchMessage(){[weak self] messges in
            guard let self = self else { return }
            if let messges = messges{
                let msgMV = MessagesMV(message: messges)
                msgVC.messagesMV = msgMV
                self.navigationController?.pushViewController(msgVC, animated: true)
            }
        }
    }
    
    @objc private func sendBtnPressed(){
        let message = messageView.text
        let password = passwordTF.textField.text
        let type = segment.selectedSegmentIndex
        rootVM.sendMessage(text: message, password: password, indexType: type)
    }
    
    fileprivate func setupViews(){
        view.addSubview(enterLbl)
        view.addSubview(messageView)
        view.addSubview(segment)
        view.addSubview(passwordTF)
        view.addSubview(sendBtn)
        
        enterLbl.edgesToSuperview(excluding: .bottom,
                                  insets: TinyEdgeInsets(top: 32,
                                                         left: 16,
                                                         bottom: 0,
                                                         right: 16),
                                  usingSafeArea: true)
        messageView.topToBottom(of: enterLbl, offset: 16)
        messageView.leadingToSuperview(offset: 20)
        messageView.trailingToSuperview(offset: 20)
        messageView.height(250)
        
        segment.topToBottom(of: messageView, offset: 20)
        segment.leadingToSuperview(offset: 20)
        segment.trailingToSuperview(offset: 20)
        segment.height(40)
        
        passwordTF.topToBottom(of: segment, offset: 20)
        passwordTF.height(55)
        passwordTF.leadingToSuperview(offset: 32)
        passwordTF.trailingToSuperview(offset: 32)
        
        sendBtn.topToBottom(of: passwordTF, offset: 20)
        sendBtn.centerXToSuperview()
        sendBtn.height(40)
        sendBtn.width(120)
        
        
    }

}

extension RootViewController: RootDelegate {
    func goTo(_ vc: UIViewController) {
        self.present(vc, animated: true, completion: nil)
    }
    
    func sureLogout(handler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "SignOut", message: "Are you sure to sign out?", preferredStyle: .alert)
        let sure = UIAlertAction(title: "Sure", style: .destructive) { (alertAction) in
            handler(true)
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel) { (alertAction) in
            handler(false)
        }
        alert.addAction(sure)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func startSend() {
        activityIndicator.text = "sendig..."
        self.present(activityIndicator, animated: true)
        self.view.endEditing(true)
    }
    
    func endSend(success: Bool, msg: String) {
        activityIndicator.dismiss(animated: true) {
            self.activityIndicator.text = nil
            if success{
                self.messageView.text = ""
                self.passwordTF.textField.text = ""
            }
            self.showAlert(msg: msg, nil)
        }
        
    }
    
    func startFetching() {
        activityIndicator.text = "fetching..."
        self.present(activityIndicator, animated: true)
        self.view.endEditing(true)
    }
    
    func endFetching(success: Bool, msg: String) {
        activityIndicator.dismiss(animated: true) {
            self.activityIndicator.text = nil
            if !success{
                self.showAlert(msg: msg, nil)
            }
        }
        
    }
    
    
}
