//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Namrata Akash on 12/04/21.
//
import  FirebaseDatabase

public class DatabaseManager
{
    private  let database = Database.database().reference()
static let shared = DatabaseManager()
   
    
    
    
    // mark: public:-
    /* check email and user name is available
     -Parameters:
       -email:String representing email
       -username:String representing username
     
     */
    public func canCreatenewUser(with email:String,username:String,completion:(Bool) -> Void)  {
        completion(true)
    }
    /* check email and user name is available
     -Parameters:
       -email:String representing email
       -username:String representing username
     
     */
    public func insertNewUser(with email:String,username:String,completion: @escaping((Bool) -> Void)){
        database.child(email.safedatabasekey()).setValue(["username": username]) { (error, _) in
            if error == nil {
                completion(true)
                return
            }
            else{
                completion(false)
                return
            }
        }
    }
}
