//
//  User.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//

import SwiftyJSON
import GRDB

class User: Record {
    
    var id: String
    var name: String
    var username: String
    var email: String
    var address: Address
    var phone: String
    var website: String
    var company: Company
    var addressId: Int = 0
    var companyId: Int = 0
    
    init(json: JSON) {
        id = json["id"].stringValue
        name = json["name"].stringValue
        username = json["username"].stringValue
        email = json["email"].stringValue
        address = Address(json: json["address"])
        phone = json["phone"].stringValue
        website = json["website"].stringValue
        company = Company(json: json["company"])
        super.init()
    }
    
    override class var databaseTableName: String {
        return "User"
    }
    
    required init(row: Row) {
        id = row["id"]
        name = row["name"]
        username = row["username"]
        email = row["email"]
        addressId = row["address"]
        address = Address.init(json: JSON())
        phone = row["phone"]
        website = row["website"]
        companyId = row["company"]
        company = Company.init(json: JSON())
        super.init(row: row)
    }
    
    override func encode(to container: inout PersistenceContainer) {
        container["id"] = id
        container["name"] = name
        container["username"] = username
        container["email"] = email
        container["address"] = address.id
        container["phone"] = phone
        container["website"] = website
        container["company"] = company.id
    }
        
    static func getUsers() -> [User] {
        let query = "SELECT * FROM \(databaseTableName)"
        var result: [User]?
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        try! appDelegate.database?.dbQueueData.inDatabase { db in
            result = try User.fetchAll(db, sql: query) }
        return result!
    }
    
    static func insertUser(user: User) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        try! appDelegate.database?.dbQueueData.inDatabase { db in
            do {
             try user.insert(db)
            } catch {
             try user.update(db)
            }
        }
    }
}
