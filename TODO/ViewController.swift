//
//  ViewController.swift
//  TODO
//
//  Created by Ma7rous on 10/11/21.
//  Copyright © 2021 Ma7rous. All rights reserved.
//

import UIKit

class ToDoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var todoItemTxt: UITextField!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    @IBOutlet weak var todoTableView: UITableView!
    
    var todos = Array<Todo>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
        
        getTodos()
    }
    
    @IBAction func addTodo(_ sender: Any) {
        guard let todoItem = todoItemTxt.text else {
            //show error "you must enter a todo item"
            return
        }
        let todo = Todo(item: todoItem, priority: prioritySegment.selectedSegmentIndex)
        NetworkService.shared.addTodo(todo: todo, onSuccess: { (todos) in
            self.todoItemTxt.text = ""
            self.todos = todos.items
            self.todoTableView.reloadData()
        }) { (errorMessage) in
            //show any errors to user on POST
            debugPrint(errorMessage)
        }
        
       
       }
    
    
        func getTodos(){

            NetworkService.shared.getTodos(onSuccess: { (todos) in
                self.todos = todos.items
                self.todoTableView.reloadData()
            }) { (errorMessage) in
                debugPrint(errorMessage)
            }
    }
        
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as? TodoCell {
            cell.updateCellFromModel(todo: todos[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        
    }

           
   
    
}

