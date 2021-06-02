//
//  Database.swift
//  Super Wow
//
//  Created by proximate on 05/03/18.
//  Copyright © 2018 proximate. All rights reserved.
//

import GRDB
import UIKit

@available(iOS 13.0, *)

class Database {
    
    var dbQueueData: DatabaseQueue!

    public func copyFileIfNeeded(nameDatabase: String) -> String {

        if let bundlePath = Bundle.main.path(forResource: nameDatabase, ofType: ".sqlite") {
            let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            print(destPath)
            let fileManager = FileManager.default

            let fullDestPath = URL(fileURLWithPath: destPath).appendingPathComponent(nameDatabase + ".sqlite")
            if fileManager.fileExists(atPath: fullDestPath.path) {
                print("Database file is exist")
                print(fileManager.fileExists(atPath: bundlePath))
            } else {
                do {
                    try fileManager.copyItem(atPath: bundlePath, toPath: fullDestPath.path)
                } catch {
                    print("\n", error)
                }
            }
            return fullDestPath.path
        }
        else { print("Not found DB") }
        return ""
    }

    public func setupDatabase(_ application: UIApplication) throws {

        let databaseDataPath = copyFileIfNeeded(nameDatabase: Globals.DB_NAME)
        dbQueueData = try DatabaseQueue(path: databaseDataPath)

    }
}
    

