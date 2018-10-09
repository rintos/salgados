//
//  MealTableViewController.swift
//  salgados
//
//  Created by Victor on 19/09/2018.
//  Copyright © 2018 Victor. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController, AddMealDelegate {
    
    //array do tipo Meal
    var meals = Array<Meal>()
    
    //funcao para adicionar um alimento no meu array
    func add(_ meal: Meal){
        print("Adding a meal: \(meal.name)")
        meals.append(meal)
        Dao().save(meals)
        
        tableView.reloadData()//forcando array recarregar dados da lista
    }
    //carregando dados do arquivo
    override func viewDidLoad() {
        self.meals = Dao().show()
    }
    
    //construindo a referencia do array para usar no viewcontroller antes de apertar o add
    //pegue o destino e onfigura nele uma variavel que eh uma referencia pra min mesmo
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addMeal"){//garantindo execucao somente em uma tela
            let view = segue.destination as! ViewController
            view.delegate = self
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let meal =  meals[row]
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel!.text = meal.name
        
        //Reconhecedor de Movimento gesture para selecionar fazer print - [Mod3]
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(showDetails))
        cell.addGestureRecognizer(longPressRecognizer)
        
        return cell
    }
    
    //identifico a celula selecionada e printa
    @objc func showDetails(recognizer: UILongPressGestureRecognizer){
        if(recognizer.state == UIGestureRecognizerState.began){
            //faco um cast para forcar o optinal
            let cell = recognizer.view as! UITableViewCell
            
            if let indexPath = tableView.indexPath(for: cell){
                let row = indexPath.row
                let meal = meals[row]
               
                RemoveMealController(controller: self).show(meal, handler : { action in
                    self.meals.remove(at: row)
                    self.tableView.reloadData()
                })
            }
        }
  
    }
    
}

