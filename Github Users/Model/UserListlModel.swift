//
//  HomeDetailModel.swift
//  gridloka
//
//  Created by Razan Nasir on 17/12/19.
//  Copyright © 2019 Razan Nasir. All rights reserved.
//

import UIKit

class UserListlModel: NSObject {
    
    var id : Int? = 0
    var login : String? = ""
    var node_id : String? = ""
    var avatar_url : String? = ""
    var gravatar_id : String? = ""
    var url : String? = ""
    var html_url : String? = ""
    var followers_url : String? = ""
    var following_url : String? = ""
    var gists_url : String? = ""
    var starred_url : String? = ""
    var subscriptions_url : String? = ""
    var organizations_url : String? = ""
    var repos_url : String? = ""
    var events_url : String? = ""
    var received_events_url : String? = ""
    var type : String? = ""
    var site_admin : Bool? = false
    var isFav : Bool? = false

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["id"] as? Int
        login = dictionary["login"] as? String
        node_id = dictionary["node_id"] as? String
        avatar_url = dictionary["avatar_url"] as? String
        gravatar_id = dictionary["gravatar_id"] as? String
        url = dictionary["url"] as? String
        html_url = dictionary["html_url"] as? String
        followers_url = dictionary["followers_url"] as? String
        following_url = dictionary["following_url"] as? String
        gists_url = dictionary["gists_url"] as? String
        starred_url = dictionary["starred_url"] as? String
        subscriptions_url = dictionary["subscriptions_url"] as? String
        organizations_url = dictionary["organizations_url"] as? String
        repos_url = dictionary["repos_url"] as? String
        events_url = dictionary["events_url"] as? String
        received_events_url = dictionary["received_events_url"] as? String
        type = dictionary["type"] as? String
        site_admin = dictionary["site_admin"] as? Bool
        isFav = false
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if id != nil{
            dictionary["id"] = id
        }
        if login != nil{
            dictionary["login"] = login
        }
        if node_id != nil{
            dictionary["node_id"] = node_id
        }
        if avatar_url != nil{
            dictionary["avatar_url"] = avatar_url
        }
        if gravatar_id != nil{
            dictionary["gravatar_id"] = gravatar_id
        }
        if url != nil{
            dictionary["url"] = url
        }
        if html_url != nil{
            dictionary["html_url"] = html_url
        }
        if followers_url != nil{
            dictionary["followers_url"] = followers_url
        }
        if following_url != nil{
            dictionary["following_url"] = following_url
        }
        if gists_url != nil{
            dictionary["gists_url"] = gists_url
        }
        if starred_url != nil{
            dictionary["starred_url"] = starred_url
        }
        if subscriptions_url != nil{
            dictionary["subscriptions_url"] = subscriptions_url
        }
        if organizations_url != nil{
            dictionary["organizations_url"] = organizations_url
        }
        if repos_url != nil{
            dictionary["repos_url"] = repos_url
        }
        if events_url != nil{
            dictionary["events_url"] = events_url
        }
        if received_events_url != nil{
            dictionary["received_events_url"] = received_events_url
        }
        if type != nil{
            dictionary["type"] = type
        }
        if site_admin != nil{
            dictionary["site_admin"] = site_admin
        }
        return dictionary
    }
    
}
