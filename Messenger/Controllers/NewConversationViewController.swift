//
//  NewConversationViewController.swift
//  Messenger
//
//  Created by OCUBE on 2022/12/15.
//

import Foundation
import UIKit
import JGProgressHUD

class NewConversationViewController:UIViewController{
    
    private let spinner = JGProgressHUD()
    
    private let searchBar:UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for Users..."
        return searchBar
    }()
    
    private let tableView:UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let noResultLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "No Results"
        label.textAlignment = .center
        label.textColor = .green
        label.font = .systemFont(ofSize: 21,weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        view.backgroundColor = .white
        //뷰 제일 상단에 searchBar을 세팅
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(dismissSelf))
        
        //UX적인 요소 서치바에 바로 타겟함
        self.searchBar.becomeFirstResponder()
    }
    
    @objc private func dismissSelf(){
        self.dismiss(animated: true,completion: nil)
    }
}

extension NewConversationViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
