//
//  ViewController.swift
//  salgados
//
//  Created by Victor on 12/09/2018.
//  Copyright © 2018 Victor. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, AddAnItemDelegate {
    
    //Outlet eh o vinculo do interface builder com o campo
    @IBOutlet var nameField: UITextField?
    @IBOutlet var happinessField: UITextField?
    var delegate: AddMealDelegate? // instanciando var do tipo classe //criando sua referencia
    var selected:Array<Item> = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        let row = indexPath.row
        let item = items[row]
        cell.textLabel!.text = item.name
        return cell
    }
    
    //ticando itens implementando uitableviedelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at:indexPath){
            if(cell.accessoryType == UITableViewCellAccessoryType.none){
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
                let item = items[indexPath.row]
                selected.append(item)
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.none
                let item = items[indexPath.row]
                if let position = selected.index(of: item) {
                    selected.remove(at: position)
                } else {
                    Alert(controller: self).show()
                }
            }
        } else {
            Alert(controller: self).show()
        }
    }
    
    var items = [Item(name: "frango", calories: 220.0),
                 Item(name: "queijo", calories: 2102.0),
                 Item(name: "carne", calories: 2210.0),
                 Item(name: "palmito", calories: 20.0),
                 Item(name: "oregano", calories: 1),
                 Item(name: "pimentao", calories: 25)]
    
    func getArchive () -> String {
        //criando arquivo
        let userDirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let dir = userDirs[0]
        print("Saving At \(dir)")
        let archive = "\(dir)/items.dados"
        return archive
    }
    
    @IBOutlet var tableView: UITableView?
    
    func add(_ item: Item) {
        print("Item Adding: \(item)")
        items.append(item)
        //gravando objeto item no arquivo com metedo
        Dao().save(items)

        if let table = tableView{
            table.reloadData()
        } else {
            Alert(controller: self).show() //invocando classe alerta com metodo show
        }
            
    }
    
    //criando botao no codigo quando tela eh iniciada
    override func viewDidLoad() {
        let newItemButton = UIBarButtonItem(title: "New Item", style: UIBarButtonItemStyle.plain, target: self, action: #selector(showNewItem))
        navigationItem.rightBarButtonItem = newItemButton
        
        //carregando arquivo com metodo
        self.items = Dao().show()
    }
    
    //mostrando a tela de add item
    @objc func showNewItem(){
        let newItem = NewItemViewController(delegate: self)
        if let navigation = navigationController {
            navigation.pushViewController(newItem, animated: true)
        } else {
            Alert(controller: self).show(message: "Nao foi possivel ir para proxima tela")
        }
    }
    
    func convertToInt(_ text:String?) -> Int? {
        if let number = text {
            return Int(number)
        }
        return nil
    }
    
    //recuperando alimento campos formulario //  arquivo do NSCoding afeta essa funcao
    func getMealFromForm() -> Meal? {
        
        if let name = nameField?.text {
            if let happiness = convertToInt(happinessField?.text) {
                
                let meal = Meal(name: name, happiness: happiness, items: selected)
                
                print("EU Comi \(String(describing: meal.name)) a nota eh \(String(describing: meal.happiness)) os itens \(meal.items)")
                return meal
            }
        }
        return nil
    }
    
    //@notacao interface builder action vinculo com botao add
    @IBAction func addSalgado() {
        if let meal = getMealFromForm() {
            if let meals = delegate{
                meals.add(meal)
                if let navigation = navigationController {
                    navigation.popViewController(animated: true)
                } else {
                    Alert(controller: self).show(message: "Unable to go back, but the meal was added.")
                }
                return
            }
        }
        Alert(controller: self).show()
    }

}



