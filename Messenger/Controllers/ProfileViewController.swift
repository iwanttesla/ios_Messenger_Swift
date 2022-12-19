//
//  ProfileViewController.swift
//  Messenger
//
//  Created by OCUBE on 2022/12/15.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet var tableView:UITableView!
    
    let data = ["로그아웃"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self

    }
}

extension ProfileViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let actionSheet = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "로그아웃", style: .destructive,handler: {[weak self]_ in
            
            guard let strongSelf = self else{
                return
            }
            do {
                try FirebaseAuth.Auth.auth().signOut()
                
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                
                nav.modalPresentationStyle = .fullScreen
                //animated false하면 애니메이션이 없음.
                strongSelf.present(nav,animated: true)
                
            }catch{
                print("Failed to log out")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel,handler: nil))
        present(actionSheet,animated: true)
        
        
        
    }
    
    
}
