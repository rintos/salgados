//
//  Alert.swift
//  salgados
//
//  Created by Victor on 28/09/2018.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    //UIViewController pertence a classe ViewController inciamos a constante controller definindo o tipo para UIViewController
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func show(_ title: String = "Sorry", message: String = "Unexpected Error.") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "Understood", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(ok)
        controller.present(alert, animated: true, completion: nil)
    }
    
}
