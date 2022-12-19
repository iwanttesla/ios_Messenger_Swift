//
//  DatabaseManager.swift
//  Messenger
//
//  Created by OCUBE on 2022/12/16.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager{
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}

extension DatabaseManager{
    public func userExists(with email:String, comlpetion: @escaping ((Bool) -> Void)){
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: {snapshot in
            guard snapshot.value as? String != nil else{
                comlpetion(false)
                return
            }
            
            comlpetion(true)
        })
    }
    
    public func insertUser(with user: ChatAppUser, completion: @escaping (Bool) -> Void ){
        database.child(user.safeEmail).setValue([
            "first_name":user.firstName,
            "last_name":user.lastName
            
        ],withCompletionBlock: { error, _ in
            guard error == nil else{
                print("데이터베이스를 쓰는데 실패함.")
                completion(false)
                return
            }
            completion(true)
        })
    }
}

struct ChatAppUser{
    let firstName:String
    let lastName:String
    let emailAddress:String
    
    var safeEmail:String{
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        return safeEmail
    }
    var profilePictureFileName:String{
        return "\(safeEmail)_profile_picture.png"
    }
    
}
