//
//  AuthManager.swift
//  Instagram
//
//  Created by Namrata Akash on 12/04/21.
//


import  FirebaseAuth

public class AuthManager
{
    
static let shared = AuthManager()
   
    
    
    
    // mark: public:-
    
    public func registerNewUser(username:String,email:String,password:String,completion: @escaping((Bool) -> Void)) {
       // username is availanle
        // email is available
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
        }
        DatabaseManager.shared.canCreatenewUser(with: email, username: username) {canCreate in
            if canCreate {
                // create an acoount
                //insert account to database
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    guard error == nil, result != nil else{
                        //firebase auth couldnnot create an account
                        completion(false)
                        return
                    }
                    //insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username, completion: { inserted in
                        if inserted {
                            completion(true)
                            return
                        }
                        else{
                            completion(false)
                            return
                        }
                        
                    })
                }
            }
            else {
                //username or email doesn't exist
                completion(false)
            }
        }
    }
    
    public func loginUser(username:String?,email:String?,password:String,completion: @escaping((Bool) -> Void)) {
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { (authresult, error) in
                guard authresult != nil, error == nil else{
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        else if let username = username {
            print(username)
        }
    }
    public func Logout(completion:(Bool) -> Void)
    {
        do
        {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch
        {
            print(error)
         completion(false)
            return
        }
    }
}
