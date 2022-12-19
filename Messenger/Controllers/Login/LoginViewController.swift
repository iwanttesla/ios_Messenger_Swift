//
//  LoginViewController.swift
//  Messenger
//
//  Created by OCUBE on 2022/12/15.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginViewController:UIViewController{
    
    //스크롤뷰를 선언 후 설정함.
    private let scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    //이미지뷰를 선언 후 설정함.
    private let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emailField:UITextField = {
        let field = UITextField()
        //대문자 설정 off
        field.autocapitalizationType = .none
        //자동수정 off
        field.autocorrectionType = .no
        //키보드 엔터타입을 설정합니다.
        field.returnKeyType = .continue
        //모서리각도를 조정합니다.
        field.layer.cornerRadius = 12
        //테두리 선의 폭을 조정합니다.
        field.layer.borderWidth = 1
        //테두리 선의 색상을 변경합니다.
        field.layer.borderColor = UIColor.lightGray.cgColor
        //필드의 placeholder를 세팅합니다.
        field.placeholder = "이메일을 입력하세요."
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        return field
        
    }()
    
    private let passwordField:UITextField = {
        let field = UITextField()
        //대문자 설정 off
        field.autocapitalizationType = .none
        //자동수정 off
        field.autocorrectionType = .no
        //키보드 엔터타입을 설정합니다.
        field.returnKeyType = .done
        //모서리각도를 조정합니다.
        field.layer.cornerRadius = 12
        //테두리 선의 폭을 조정합니다.
        field.layer.borderWidth = 1
        //테두리 선의 색상을 변경합니다.
        field.layer.borderColor = UIColor.lightGray.cgColor
        //필드의 placeholder를 세팅합니다.
        field.placeholder = "비밀번호를 입력하세요."
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        field.isSecureTextEntry = true
        
        return field
        
    }()
    
    private let loginBtn:UIButton = {
        let loginBtn = UIButton()
        loginBtn.layer.cornerRadius = 12
        loginBtn.setTitle("로그인", for: .normal)
        loginBtn.backgroundColor = .link
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.layer.masksToBounds = true
        loginBtn.titleLabel?.font = .systemFont(ofSize: 20,weight: .bold)
        
        return loginBtn
    }()
    
    private let imageBtn:UIButton = {
        let imgBtn = UIButton()
        imgBtn.setImage(UIImage(named: "logo"), for: .normal)
        
        return imgBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Log in"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        loginBtn.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        imageBtn.addTarget(self, action: #selector(tapImage), for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        //add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageBtn)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginBtn)
        scrollView.addSubview(imageBtn)
    }
    
    //MARK: - layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //스크롤뷰를 전체화면으로 만듬
        scrollView.frame = view.bounds
        //정사각형으로 만듬
        let size = scrollView.width / 3
        imageBtn.frame = CGRect(x: (scrollView.width-size) / 2,
                                 y: 20,
                                 width: size,
                                 height: size)
//        imageView.frame = CGRect(x: (scrollView.width-size) / 2,
//                                 y: 20,
//                                 width: size,
//                                 height: size)
        emailField.frame = CGRect(x: 30,
                                  y: imageBtn.bottom + 50, //이미지뷰 bottom_margin 10을 줍니다.
                                  width: scrollView.width - 60,
                                 height: 52)
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 10, //이메일필드 bottom_margin 10을 줍니다.
                                     width: scrollView.width - 60,
                                     height: 52)
        
        loginBtn.frame = CGRect(x: scrollView.width / 3,
                                y: passwordField.bottom + 10, //비밀번호필드 bottom_margin 50을 줍니다.
                                width: scrollView.width / 3,
                                height: 52)
        
        
        
    }
    
    //MARK: - objc private function
    @objc private func loginButtonTapped(){
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text,
              !email.isEmpty,!password.isEmpty,password.count >= 8 else {
            //아이디 패스워드가 비어있거나 패스워드가 8보다작으면 에러함수를 호출함
            alertUserLoginError()
            return
            
        }
        
        //파이어베이스 로그인 로직
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password,completion: {[weak self] authResult,error in
            guard let strongSelf = self else{
                return
            }
            
            guard let result = authResult,error == nil else{
                //로그인실패
                print("Fail \(email)")
                return
            }
            //로그인 성공
            let user = result.user
            print("user : \(user.email)")
            
            strongSelf.navigationController?.dismiss(animated: true,completion: nil)
        })
    }
    
    @objc private func tapImage(){
        print("image click")
    }
    
    func alertUserLoginError(){
        let alert = UIAlertController(title: "경고", message: "로그인 정보를 확인해주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel,handler: nil))
        present(alert,animated: true)
    }
    
    @objc private func didTapRegister(){
        let vc = RegisterViewController()
        
        vc.title = "Create Account"
        
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension LoginViewController:UITextFieldDelegate{
    
    //키보드의 엔터키를 눌렀을때의 델리겟
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField{
            //비밀번호 필드를 포커싱한다.
            passwordField.becomeFirstResponder()
        }else if textField == passwordField{
            loginButtonTapped()
        }
        return true
        
    }
    
}
