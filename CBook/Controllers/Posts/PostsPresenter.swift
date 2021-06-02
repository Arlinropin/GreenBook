//
//  PostsPresenter.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//  
//

import Foundation

class PostsPresenter  {
    
    // MARK: Properties
    weak var view: PostsViewProtocol?
    var interactor: PostsInteractorInputProtocol?
    var wireFrame: PostsWireFrameProtocol?
    
    func getPosts(id: String, callbackSuccess: @escaping ([Post])->Void){
        interactor!.getPosts(id: id, callbackSuccess: { [self] response in
            if response is [Post]{
                callbackSuccess(response as! [Post])
            } else if response is Errors {
                errorsManage(response as! Errors)
            } else {
                print("Failure response")
            }
        }, callbackFailure: { [self] error in
            errorsManage(error)
        })
    }
    
    func errorsManage(_ error: Errors) {
        switch error {
        case .service:
            break
        case .url, .unknown:
            break
        default:
            break
        }
    }
}

extension PostsPresenter: PostsPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension PostsPresenter: PostsInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
