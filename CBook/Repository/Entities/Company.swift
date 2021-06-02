//
//  Company.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//

import SwiftyJSON
import GRDB

class Company: Record{
    
    var id: String = ""
    var name: String = ""
    var catchPhrase: String = ""
    var bs: String = ""
    
    init(json: JSON) {
        name = json["name"].stringValue
        catchPhrase = json["catchPhrase"].stringValue
        bs = json["bs"].stringValue
        super.init()
    }
    
    override class var databaseTableName: String {
        return "Company"
    }
    
    required init(row: Row) {
        id = row["id"]
        name = row["name"]
        catchPhrase = row["catchPhrase"]
        bs = row["bs"]
        super.init(row: row)
    }
    
    override func encode(to container: inout PersistenceContainer) {
        container["name"] = name
        container["catchPhrase"] = catchPhrase
        container["bs"] = bs
    }
        
    static func getCompanyById(id: String) -> Company {
        let query = "SELECT * FROM \(databaseTableName) where id = \(id)"
        var result: Company?
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        try! appDelegate.database?.dbQueueData.inDatabase { db in
            result = try Company.fetchOne(db, sql: query) }
        return result ?? Company(json: JSON())
    }
    
    static func getLastCompany() -> Company {
        let query = "SELECT * FROM \(databaseTableName) ORDER BY id DESC LIMIT 1"
        var result: Company?
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        try! appDelegate.database?.dbQueueData.inDatabase { db in
            result = try Company.fetchOne(db, sql: query) }
        return result ?? Company(json: JSON())
    }
    
    static func getAll() -> [Company] {
        let query = "SELECT * FROM \(databaseTableName)"
        var result: [Company]?
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        try! appDelegate.database?.dbQueueData.inDatabase { db in
            result = try Company.fetchAll(db, sql: query) }
        return result!
    }
    
    static func insertCompany(company: Company) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        try! appDelegate.database?.dbQueueData.inDatabase { db in
            do {
             try company.insert(db)
            } catch {
             try company.update(db)
            }
        }
    }
}
