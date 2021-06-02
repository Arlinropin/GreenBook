//
//  UsersInteractor.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//  
//

import Foundation

class UsersInteractor: UsersInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: UsersInteractorOutputProtocol?

    func getUsers(callbackSuccess: @escaping (Any)->Void, callbackFailure: @escaping (Errors)->Void){
        let users: [User] = User.getUsers()
        if users.count > 0{
            for item in users {
                let address = Address.getAddressById(id: "\(item.addressId)")
                let company = Company.getCompanyById(id: "\(item.companyId)")
                item.address = address
                item.company = company
            }
            callbackSuccess(users)
        } else {
            Webservices.GetUsers(callbackSuccess: { response in
                if response is [User]{
                    let users = response as! [User]
                    for item in users {
                        Address.insertAddress(address: item.address)
                        Company.insertCompany(company: item.company)
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                            let address = Address.getLastAddress()
                            let company = Company.getLastCompany()
                            item.address = address
                            item.company = company
                            User.insertUser(user: item)}
                    }
                    callbackSuccess(users)
                } else {
                    callbackSuccess(response)
                }
            }, callbackFailure: callbackFailure)
        }
        
    }
}

