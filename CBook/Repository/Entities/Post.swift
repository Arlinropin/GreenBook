//
//  Post.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//

import SwiftyJSON

class Post {
    
    var userId: String
    var id: String = ""
    var title: String = ""
    var body: String = ""
    var isFavorite: Bool = false
    
    init(json: JSON){
        userId = json["userId"].stringValue
        id = json["id"].stringValue
        title = json["title"].stringValue
        body = json["body"].stringValue
    }
}
