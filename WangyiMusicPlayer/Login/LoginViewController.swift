//
//  LoginViewController.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/2/11.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import Foundation
import SnapKit

class LoginViewController: UIViewController, UITextFieldDelegate {
 
    static var accountNumString = ""
    static var password = ""
    var string: String? = ""
    
    let accountTextField: UITextField = {
        let field = UITextField()
        field.borderStyle = UITextBorderStyle.roundedRect
        field.frame = CGRect(x: 0, y: 0, width: 300, height: 30)
        field.placeholder = "请输入手机账号"
        field.clearButtonMode = .whileEditing
        field.becomeFirstResponder()
        field.returnKeyType = .done
        return field
    }()
    
    let passwordTextField: UITextField = {
        let field = UITextField()
        field.borderStyle = UITextBorderStyle.roundedRect
        field.placeholder = "请输入密码"
        field.clearButtonMode = .whileEditing
        field.returnKeyType = .done
        field.isSecureTextEntry = true
        return field
    }()
    
    let logoView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.image = #imageLiteral(resourceName: "logo")
        //view.image = #imageLiteral(resourceName: "logo").reSizeImage(reSize: CGSize(width: 80, height: 80))
        view.clipsToBounds = true
        //view.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("登陆", for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    
    func setupView() {
        view.addSubview(logoView)
        view.addSubview(accountTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        logoView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(-120)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        accountTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.width.equalTo(250)
            make.height.equalTo(30)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(40)
            make.width.equalTo(250)
            make.height.equalTo(30)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(90)
            make.width.equalTo(250)
            make.height.equalTo(40)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white

        setupView()
        
        LoginViewController.password = getPasswordString()
        LoginViewController.accountNumString = getAccountString()
        print(LoginViewController.accountNumString, LoginViewController.password)

    }
    
    func getAccountString() -> String {
        textFieldDidEndEditing(accountTextField)
        return accountTextField.text!
    }
    
    func getPasswordString() -> String {
        textFieldDidEndEditing(passwordTextField)
        return accountTextField.text!
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        string = textField.text
    }
}
