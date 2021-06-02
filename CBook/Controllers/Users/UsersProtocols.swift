//
//  UsersProtocols.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//  
//

import Foundation
import UIKit

protocol UsersViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: UsersPresenterProtocol? { get set }
}

protocol UsersWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createUsersModule() -> UIViewController
    func showPostsView(user: User, from view: UsersViewProtocol)
}

protocol UsersPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: UsersViewProtocol? { get set }
    var interactor: UsersInteractorInputProtocol? { get set }
    var wireFrame: UsersWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func getUsers(callbackSuccess: @escaping ([User])->Void)
    func showPosts(user: User)
}

protocol UsersInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol UsersInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: UsersInteractorOutputProtocol? { get set }
    func getUsers(callbackSuccess: @escaping (Any)->Void, callbackFailure: @escaping (Errors)->Void)
}



