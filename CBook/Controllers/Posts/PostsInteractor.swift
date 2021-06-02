//
//  PostsInteractor.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//  
//

import Foundation

class PostsInteractor: PostsInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: PostsInteractorOutputProtocol?

    func getPosts(id: String, callbackSuccess: @escaping (Any)->Void, callbackFailure: @escaping (Errors)->Void){
        Webservices.GetPosts(id: id, callbackSuccess: callbackSuccess, callbackFailure: callbackFailure)
    }
}

