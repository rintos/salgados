//
//  NewItemViewController.swift
//  salgados
//
//  Created by Victor on 24/09/2018.
//  Copyright © 2018 Victor. All rights reserved.
//

import UIKit

class NewItemViewController: UIViewController {

    
    var delegate:AddAnItemDelegate?
    
    init(delegate: AddAnItemDelegate) {
        super.init(nibName: "NewItemViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBOutlet var nameField:UITextField?
    @IBOutlet var caloriesField:UITextField?
    
    @IBAction func addNewItem(){
        let name = nameField!.text
        let calories = Double(caloriesField!.text!)
        
        if (name == nil  || calories == nil){
            return
        }
        
        let item = Item(name: name!, calories: calories!)
        delegate!.add(item)
        
        print("adicionando novo item")
        if let navigation = navigationController{
            navigation.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
