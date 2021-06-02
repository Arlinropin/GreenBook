//
//  Navigation.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//

import UIKit

class Navigation {
    
    static var spinner: Spinner?
    static var viewBack = UIView()
    static var view: ModalUserData?
       
    static func getCurrentController() -> UIViewController? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.globalNavigationController?.viewControllers.last
    }
    
    static func showPersonalDataView(user: User){
        let currentController = Navigation.getCurrentController()
        viewBack.frame = UIScreen.main.bounds
        viewBack.backgroundColor = UIColor.black.withAlphaComponent(0.7)

        view = ModalUserData()
        view!.user = user
        view!.view.frame = UIScreen.main.bounds
        view!.callback = { closePersonalDataView() }
        viewBack.addSubview(view!.view)
        UIView.animate(withDuration: 0.3, animations: {viewBack.alpha = 1.0}, completion: {(value: Bool) in currentController!.view.addSubview(viewBack) })
    }
    
    static func closePersonalDataView(){
        UIView.animate(withDuration: 0.1, animations: {viewBack.alpha = 0.0}, completion: {(value: Bool) in
            viewBack.removeFromSuperview()
        })
    }
    
    static func showSpinner() {
        Spinner.showSpinner()
    }
    
    static func closeSpinner(_ completion: @escaping (() -> Void) = {}) {
        Spinner.closeSpinner(completion: completion)
    }
}
