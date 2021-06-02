//
//  PostsProtocols.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//  
//

import Foundation
import UIKit

protocol PostsViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: PostsPresenterProtocol? { get set }
}

protocol PostsWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createPostsModule(user: User) -> UIViewController
}

protocol PostsPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: PostsViewProtocol? { get set }
    var interactor: PostsInteractorInputProtocol? { get set }
    var wireFrame: PostsWireFrameProtocol? { get set }
    func getPosts(id: String, callbackSuccess: @escaping ([Post])->Void)
    func viewDidLoad()
}

protocol PostsInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol PostsInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: PostsInteractorOutputProtocol? { get set }
    func getPosts(id: String, callbackSuccess: @escaping (Any)->Void, callbackFailure: @escaping (Errors)->Void)
}



