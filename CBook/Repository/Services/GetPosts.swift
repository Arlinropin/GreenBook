//
//  GetPosts.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//

import SwiftyJSON

extension Webservices {
    static func GetPosts(id: String = "", callbackSuccess: @escaping (Any)->Void, callbackFailure: @escaping (Errors)->Void){
        print("============ OBTENER POSTS ==============")
        Webservices.request(pathMethod : id == "" ? .URL_POST_POSTS:.URL_POST_POST_BY_USER, pathMethodXtra: id, callbackSuccess:{ response in
            if response != nil {
                if let postsJSON = response?.arrayValue{
                    var posts: [Post] = []
                    for item in postsJSON {
                        posts.append(Post(json: item))
                    }
                    callbackSuccess(posts)
                } else {
                    callbackFailure(.service)
                }
            } else {
                callbackFailure(.service)
            }
        }, callbackFailure: callbackFailure)
    }
}
