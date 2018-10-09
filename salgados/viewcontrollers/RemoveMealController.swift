//
//  RemoveMealController.swift
//  salgados
//
//  Created by Victor on 04/10/2018.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation
import UIKit

class RemoveMealController {
    
    let controller: UIViewController
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func show(_ meal: Meal, handler: @escaping (UIAlertAction) -> Void) {
        //construindo janela de alerta// criou modal
        let details = UIAlertController(title: meal.name, message: meal.details(), preferredStyle:UIAlertControllerStyle.alert)
        
        //criando botao remove executando metodo
        let remove = UIAlertAction(title: "Remove", style: UIAlertActionStyle.destructive, handler: handler)
        details.addAction(remove)
        
        //criando botao
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        details.addAction(cancel)
        
        
        
        //criando janela de alerta
        controller.present(details, animated: true, completion: nil)
    }
}
