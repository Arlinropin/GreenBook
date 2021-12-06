//
//  UsersProtocols.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//  
//

import Foundation
import UIKit

protocol UsersViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: UsersPresenterProtocol? { get set }
}

protocol UsersWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createUsersModule() -> UIViewController
    func showPostsView(user: User, from view: UsersViewProtocol)
}

protocol UsersPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: UsersViewProtocol? { get set }
    var interactor: UsersInteractorInputProtocol? { get set }
    var wireFrame: UsersWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func getUsers(callbackSuccess: @escaping ([User])->Void)
    func showPosts(user: User)
}

protocol UsersInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
}

protocol UsersInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: UsersInteractorOutputProtocol? { get set }
    func getUsers(callbackSuccess: @escaping (Any)->Void, callbackFailure: @escaping (Errors)->Void)
}



