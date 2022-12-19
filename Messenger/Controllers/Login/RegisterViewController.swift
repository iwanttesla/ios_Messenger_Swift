//
//  RegisterViewController.swift
//  Messenger
//
//  Created by OCUBE on 2022/12/15.
//

import Foundation
import UIKit
import FirebaseAuth

class RegisterViewController:UIViewController{
    
    
    //스크롤뷰를 선언 후 설정함.
    private let scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    //이미지뷰를 선언 후 설정함.
    private let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
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
    
    private let firstNameField:UITextField = {
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
        field.placeholder = "성"
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        return field
        
    }()
    
    private let lastNameField:UITextField = {
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
        field.placeholder = "이름"
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        return field
        
    }()
    
    private let registerBtn:UIButton = {
        let registerBtn = UIButton()
        registerBtn.layer.cornerRadius = 12
        registerBtn.setTitle("회원가입", for: .normal)
        registerBtn.backgroundColor = .gray
        registerBtn.setTitleColor(.white, for: .normal)
        registerBtn.layer.masksToBounds = true
        registerBtn.titleLabel?.font = .systemFont(ofSize: 20,weight: .bold)
        
        return registerBtn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Register"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        registerBtn.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        //상호작용을 할수 있게 설정함
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
        
        imageView.addGestureRecognizer(gesture)
        
        //add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerBtn)
        scrollView.addSubview(imageView)
    }
    
    //MARK: - layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //스크롤뷰를 전체화면으로 만듬
        scrollView.frame = view.bounds
        //정사각형으로 만듬
        let size = scrollView.width / 3
        imageView.frame = CGRect(x: (scrollView.width-size) / 2,
                                y: 20,
                                width: size,
                                height: size)
        imageView.layer.cornerRadius = imageView.height / 2
        firstNameField.frame = CGRect(x: 30,
                                  y: imageView.bottom + 50, //이미지뷰 bottom_margin 10을 줍니다.
                                  width: scrollView.width - 60,
                                  height: 52)
        lastNameField.frame = CGRect(x: 30,
                                  y: firstNameField.bottom + 10, //이미지뷰 bottom_margin 10을 줍니다.
                                  width: scrollView.width - 60,
                                  height: 52)
        emailField.frame = CGRect(x: 30,
                                  y: lastNameField.bottom + 10, //이미지뷰 bottom_margin 10을 줍니다.
                                  width: scrollView.width - 60,
                                  height: 52)
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 10, //이메일필드 bottom_margin 10을 줍니다.
                                     width: scrollView.width - 60,
                                     height: 52)
        
        registerBtn.frame = CGRect(x: scrollView.width / 3,
                                y: passwordField.bottom + 10, //비밀번호필드 bottom_margin 50을 줍니다.
                                width: scrollView.width / 3,
                                height: 52)
        
        
        
    }
    
    //MARK: - objc private function
    @objc private func registerButtonTapped(){
        
        //키보드를 내려줌
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
                  !firstName.isEmpty,
                  !lastName.isEmpty,
                  !email.isEmpty,
                  !password.isEmpty,password.count >= 8 else {
                //아이디 패스워드가 비어있거나 패스워드가 8보다작으면 에러함수를 호출함
                alertUserregisterError(message: "로그인 정보를 확인해주세요.")
            return
            
        }
        
        //파이어베이스 로그인 로직
        DatabaseManager.shared.userExists(with: email, comlpetion: { [weak self] exist in
            
            guard let strongSelf = self else{
                return
            }
            
            guard !exist else{
                //이미 이메일이 있음
                strongSelf.alertUserregisterError(message: "이미 이메일이 있습니다.")
                return
            }
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password,completion:{ authResult,error in
                
                
                guard authResult != nil, error == nil else{
                    print("Error create user")
                    //회원가입 실패
                    return
                }
                //로그인 성공
                DatabaseManager.shared.insertUser(with: ChatAppUser(firstName: firstName, lastName: lastName, emailAddress: email))
                strongSelf.navigationController?.dismiss(animated: true,completion: nil)
                
            })
        })
        
        
    }
    
    @objc private func didTapChangeProfilePic(){
        print("image click")
        
        presentPhotoActionSheet()
        
    }
    
    func alertUserregisterError(message:String){
        let alert = UIAlertController(title: "경고", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel,handler: nil))
        present(alert,animated: true)
    }
    
}


extension RegisterViewController:UITextFieldDelegate{
    
    //키보드의 엔터키를 눌렀을때의 델리겟
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case firstNameField:
            lastNameField.becomeFirstResponder()
        case lastNameField:
            emailField.becomeFirstResponder()
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            registerButtonTapped()
        default:
            break
        }
        return true
        
    }
    
    
}

//액션시트 델리겟
extension RegisterViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "프로필 사진", message: "사진을 선택해주세요.", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel,handler: nil))
        actionSheet.addAction(UIAlertAction(title: "사진찍기", style: .default,handler: {[weak self]_ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "사진가져오기", style: .default,handler: {[weak self]_ in
            self?.presentPhotoPicker()
        }))
        
        present(actionSheet,animated: true)
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc,animated: true)
    }
    
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true,completion: nil)
        print(info)
        //originalImage 원본이미지
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        self.imageView.image = selectedImage
    }
    
    //취소할때 호출
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true,completion: nil)
    }
}

