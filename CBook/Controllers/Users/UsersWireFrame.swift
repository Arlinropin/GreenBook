//
//  UsersWireFrame.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//  
//

import Foundation
import UIKit

class UsersWireFrame: UsersWireFrameProtocol {

    class func createUsersModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "UsersView")
        if let view = navController as? UsersView {//navController.children.first solo para las primeras vistas
            let presenter: UsersPresenterProtocol & UsersInteractorOutputProtocol = UsersPresenter()
            let interactor: UsersInteractorInputProtocol = UsersInteractor()
            let wireFrame: UsersWireFrameProtocol = UsersWireFrame()
            
            view.presenter = presenter
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
    
    func showPostsView(user: User, from view: UsersViewProtocol) {
        let new = PostsWireFrame.createPostsModule(user: user)
        if let newView = view as? UIViewController{
            newView.navigationController?.pushViewController(new, animated: true)
        }
    }
    
}
