//
//  Dao.swift
//  salgados
//
//  Created by Victor on 06/10/2018.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

class Dao {
    
    let mealsArchive:String
    let itemsArchive:String
    
    init() {
        let userDirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let dir = userDirs[0]
        print("Reading from \(dir)")
        mealsArchive = "\(dir)/comidasalgado.dados"
        itemsArchive = "\(dir)/comidaigredientes.dados"
        
    }
    
    func save(_ meals: Array<Meal>) {
        NSKeyedArchiver.archiveRootObject(meals, toFile: mealsArchive)
    }
    
    func show() -> Array<Meal> {
        if let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: mealsArchive){
           let meals = loaded as! Array<Meal>
            return meals
        }
        return []
    }
    
    func save(_ items: Array<Item>) {
        NSKeyedArchiver.archiveRootObject(items, toFile: itemsArchive)
    }
    
    
    func show() -> Array<Item> {
        if let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: itemsArchive){
            let items = loaded as! Array<Item>
            return items
        }
        return []
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
