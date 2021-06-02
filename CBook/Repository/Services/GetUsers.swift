//
//  GetUsers.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//

import SwiftyJSON

extension Webservices {
    static func GetUsers(callbackSuccess: @escaping (Any)->Void, callbackFailure: @escaping (Errors)->Void){
        print("============ OBTENER USUARIOS ==============")
        Webservices.request(pathMethod : .URL_POST_USERS, callbackSuccess:{ response in
            if response != nil {
                if let usersJSON = response?.arrayValue {
                    var users: [User] = []
                    for item in usersJSON {
                        users.append(User(json: item))
                    }
                    callbackSuccess(users)
                } else {
                    callbackFailure(.service)
                }
            } else {
                callbackFailure(.service)
            }
        }, callbackFailure: callbackFailure)
    }
}
