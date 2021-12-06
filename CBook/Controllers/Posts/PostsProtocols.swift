//
//  PostsProtocols.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//  
//

import Foundation
import UIKit

protocol PostsViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: PostsPresenterProtocol? { get set }
}

protocol PostsWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createPostsModule(user: User) -> UIViewController
}

protocol PostsPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: PostsViewProtocol? { get set }
    var interactor: PostsInteractorInputProtocol? { get set }
    var wireFrame: PostsWireFrameProtocol? { get set }
    func getPosts(id: String, callbackSuccess: @escaping ([Post])->Void)
    func viewDidLoad()
}

protocol PostsInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
}

protocol PostsInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: PostsInteractorOutputProtocol? { get set }
    func getPosts(id: String, callbackSuccess: @escaping (Any)->Void, callbackFailure: @escaping (Errors)->Void)
}



