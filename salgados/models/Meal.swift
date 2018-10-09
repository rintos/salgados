//
//  Meal.swift
//  salgados
//
//  Created by Victor on 17/09/2018.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

class Meal: NSObject, NSCoding {
    let name: String
    let happiness: Int
    let items:Array<Item>
    
    init(name: String, happiness: Int, items: Array<Item>) {
        self.name = name
        self.happiness = happiness
        self.items = items
    }
    //deserializar // desconstruir arquivo
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.happiness = aDecoder.decodeInteger(forKey: "happiness")
        self.items = aDecoder.decodeObject(forKey: "items") as! Array
    }
    //serializar // criar arquivo
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(happiness, forKey: "happiness")
        aCoder.encode(items, forKey: "items")
    }
    
    //nao precisa desse inicilizador apenas definir um valor padrao no parametro array nesse caso
    init(name: String, happiness: Int) {
        self.name = name
        self.happiness = happiness
        self.items = []
    }
    
    func allCalories () -> Double{
        var total = 0.0
        for item in items {
            total += item.calories
        }
        return total
    }
    
    //populando alert com os itens
    func details() -> String{
        var message = "Happiness: \(happiness)"
        for item in items {
            message += "\n \(item.name) - Calories : \(item.calories)"
        }
        return message
    }
   
}
