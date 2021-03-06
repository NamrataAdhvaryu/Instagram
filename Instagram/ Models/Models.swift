//
//  Models.swift
//  Instagram
//
//  Created by Namrata Akash on 16/04/21.
//

import Foundation
enum Gender {
    case male,female,other
}
struct User {
    let username:String
    let bio:String
    let profilpicture:URL
    let name: (first:String, last:String)
    let birthdate:Date
    let gender:Gender
    let counts:Usercount
    let joinDate:Date
}
struct Usercount {
    let following:Int
    let follwers:Int
    let posts:Int
}
public enum Userposttype:String {
    case photo = "photo"
    case video = "video"
}


public struct userPost {
    let identifier:String
    let postType : Userposttype
    let thumbnailimage: URL
    let postURL : URL // either video url or full resolution photo
    let caption: String
    let likecount: [Postlike]
    let commnents: [Postcomments]
    let createddate: Date
    let taggedUsers : [String]
    let owner:User
    
}
public struct Postlike {
    let username: String
    let postidentifier:String
}
public  struct Commnentlike {
    let username: String
    let Commentidentifier:String
}
public struct Postcomments {
    let identifier:String
    let username:String
    let text: String
    let createddate : Date
    let likes:[Commnentlike]
}
