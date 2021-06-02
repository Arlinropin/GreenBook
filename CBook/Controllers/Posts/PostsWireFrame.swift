//
//  PostsWireFrame.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//  
//

import Foundation
import UIKit

class PostsWireFrame: PostsWireFrameProtocol {

    class func createPostsModule(user: User) -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "PostsView")
        if let view = navController as? PostsView {//navController.children.first solo para las primeras vistas
            let presenter: PostsPresenterProtocol & PostsInteractorOutputProtocol = PostsPresenter()
            let interactor: PostsInteractorInputProtocol = PostsInteractor()
            let wireFrame: PostsWireFrameProtocol = PostsWireFrame()
            
            view.presenter = presenter
            view.user = user
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}
