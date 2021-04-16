//
//  Storage.swift
//  Instagram
//
//  Created by Namrata Akash on 12/04/21.
//


import FirebaseStorage
public class StorageManager
{
    
static let shared = StorageManager()
    private let bucket = Storage.storage().reference()
   public enum IGStorageManagererror:Error {
        case failedtodownload
    }
    
    func  uploaduserphotopost(model:userPost, completion:(Result<URL,Error>) -> Void)  {
    
    }
    func downloadimage(with reference:String,completion:@escaping(Result<URL,IGStorageManagererror>) -> Void) {
        bucket.child(reference).downloadURL { (url, error) in
            guard let url = url , error == nil else {
                completion(.failure(.failedtodownload))
                return
            }
            completion(.success(url))
        }
        
    }
   
}
