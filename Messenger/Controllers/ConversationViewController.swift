//
//  ViewController.swift
//  Messenger
//
//  Created by OCUBE on 2022/12/15.
//

import UIKit
import FirebaseAuth

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        validateAuth()
        
    }
    
    //로그인을 했는지 검증함.
    private func validateAuth(){
        if FirebaseAuth.Auth.auth().currentUser == nil{
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            
            nav.modalPresentationStyle = .fullScreen
            //animated false하면 애니메이션이 없음.
            present(nav,animated: false)
        }
    }

}

