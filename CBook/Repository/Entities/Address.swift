//
//  Address.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//

import SwiftyJSON
import GRDB

class Address: Record {
    var id: String = ""
    var street: String = ""
    var suite: String = ""
    var city: String = ""
    var zipcode: String = ""
    var geo: Geo = Geo(lat: 0.0, lng: 0.0)
    
    init (json: JSON){
        street = json ["street"].stringValue
        suite = json ["suite"].stringValue
        city = json ["city"].stringValue
        zipcode = json ["zipcode"].stringValue
        geo = Geo(lat: json["geo"]["lat"].doubleValue, lng: json["geo"]["lng"].doubleValue)
        super.init()
    }
    
    override class var databaseTableName: String {
        return "Address"
    }
    
    required init(row: Row) {
        id = row["id"]
        street = row["street"]
        suite = row["suite"]
        city = row["city"]
        zipcode = row["zipcode"]
        geo = Geo(lat: row["lat"], lng: row["lng"])
        super.init(row: row)
    }
    
    override func encode(to container: inout PersistenceContainer) {
        container["street"] = street
        container["suite"] = suite
        container["city"] = city
        container["zipcode"] = zipcode
        container["lat"] = geo.lat
        container["lng"] = geo.lng
    }
        
    static func getAddressById(id: String) -> Address {
        let query = "SELECT * FROM \(databaseTableName) where id = \(id)"
        var result: Address?
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        try! appDelegate.database?.dbQueueData.inDatabase { db in
            result = try Address.fetchOne(db, sql: query) }
        return result ?? Address(json: JSON())
    }
    
    static func getLastAddress() -> Address {
        let query = "SELECT * FROM \(databaseTableName) ORDER BY id DESC LIMIT 1"
        var result: Address?
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        try! appDelegate.database?.dbQueueData.inDatabase { db in
            result = try Address.fetchOne(db, sql: query) }
        return result ?? Address(json: JSON())
    }
    
    static func getAll() -> [Address] {
        let query = "SELECT * FROM \(databaseTableName)"
        var result: [Address]?
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        try! appDelegate.database?.dbQueueData.inDatabase { db in
            result = try Address.fetchAll(db, sql: query) }
        return result!
    }
    
    static func insertAddress(address: Address) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        try! appDelegate.database?.dbQueueData.inDatabase { db in
            do {
             try address.insert(db)
            } catch {
             try address.update(db)
            }
        }
    }
}

struct Geo {
    var lat: Double
    var lng: Double
}
