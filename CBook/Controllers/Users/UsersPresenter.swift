//
//  UsersPresenter.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//  
//

import Foundation

class UsersPresenter  {
    
    // MARK: Properties
    weak var view: UsersViewProtocol?
    var interactor: UsersInteractorInputProtocol?
    var wireFrame: UsersWireFrameProtocol?
    
    func getUsers(callbackSuccess: @escaping ([User])->Void){
        interactor!.getUsers(callbackSuccess: { [self] response in
            if response is [User]{
                callbackSuccess(response as! [User])
            } else if response is Errors {
                errorsManage(response as! Errors)
            } else {
                print("Failure response")
            }
        }, callbackFailure: { [self] error in
            errorsManage(error)
        })
        
    }
    
    func showPosts(user: User){
        wireFrame!.showPostsView(user: user, from: view!)
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

extension UsersPresenter: UsersPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension UsersPresenter: UsersInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
