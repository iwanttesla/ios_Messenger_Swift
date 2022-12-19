//
//  StorageManager.swift
//  Messenger
//
//  Created by OCUBE on 2022/12/19.
//

import Foundation
import FirebaseStorage

final class StorageManager{
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    /*
     /images/skywolf321-naver-com_profile_picture.png
     */
    
    public typealias UploadPictureCompletion = (Result<String,Error>) -> Void
    
    /// 파이어 베이스에 올린 사진을 url string 으로 변경 다운로드함
    public func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping UploadPictureCompletion){
        storage.child("image/\(fileName)").putData(data,metadata: nil,completion: { metadata,error in
            guard error == nil else{
                //failed
                print("파이어 베이스에 사진업로드를 실패했습니다.")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self.storage.child("image/\(fileName)").downloadURL(completion: {url, error in
                guard let url = url else{
                    print("url을 가져오는데 실패했습니다.")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                let urlString = url.absoluteString
                print(urlString)
                completion(.success(urlString))
            })
            
            
        })
    }
    
    public enum StorageErrors: Error{
        case failedToUpload
        case failedToGetDownloadUrl
    }
}
