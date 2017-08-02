//
//  StudentsTableViewController.swift
//  StudentPut
//
//  Created by Alex Aslett on 8/2/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class StudentsTableViewController: UITableViewController {
    
    
    // MARK: - IBOutlets
    
 
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StudentController.fetchStudents {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, name != "" else { return }
        StudentController.putStudentWith(name: name) { (success) in
            guard success else { return }
            
            DispatchQueue.main.async {
                self.nameTextField.text = ""
                self.nameTextField.resignFirstResponder()
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - TableView Data Souce
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentController.students.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)
        
        let student = StudentController.students[indexPath.row]
        cell.textLabel?.text = student.name
        
        return cell
        
    }
    
}
