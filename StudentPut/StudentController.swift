//
//  StudentController.swift
//  StudentPut
//
//  Created by Alex Aslett on 8/2/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation

class StudentController {
    
    // Data Storce
    static var students: [Student] = []
    
    // BaseURL
    static let baseURL = URL(string: "https://survey-ios14.firebaseio.com/students")
    
    // Fetch Students
    static func fetchStudents(completion: @escaping () -> Void) {
        //build the URL - append path components and extensions
        
        guard let url = baseURL?.appendingPathExtension("json") else { completion(); return }
        
        //URLComponents - we only need this if we are going to append Query Paramters
        //build a request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil
        //Create and run a datatask
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            //Check for an error
            if let error = error {
                NSLog("There was an error: \(error.localizedDescription)")
                completion()
                return
            }
            
            //Unwrap the data
            guard let data = data else {
                NSLog("No data returned from the dataTask")
                completion()
                return
            }
            //serialize(Parse) the Json
            guard let studentsDictionary = (try? JSONSerialization.jsonObject(with: data, options: [.allowFragments])) as? [String: [String: String]] else {
                NSLog("Unable to serilaize JSON")
                completion()
                return
            }
            //Create our students
            
            students = studentsDictionary.flatMap { Student(dictionary: $0.value) }
            
            //Call our completion when the task is complete
            completion()
        }
        dataTask.resume()
        
    }
    
    
    // Post students to the API
    
    static func putStudentWith(name: String, completion: @escaping (_ success: Bool) -> Void) {
        //Build URL
        
        //Create the student
        let student = Student(name: name)
        
        guard let url = baseURL?.appendingPathComponent(UUID().uuidString).appendingPathExtension("json") else {
            completion(false);
            return
        }
        
        //Create a Request
        var request = URLRequest(url: url)
        //set the request parameters
        request.httpMethod = "PUT"
        //Covert the JSON into data
        request.httpBody = student.jsonData
        
        //create a data task and resume
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data else { completion(false); return }
            //Check for an error
            if let error = error {
                NSLog("Error: \(error.localizedDescription)")
                completion(false)
                return
            } else {
            students.append(student)
            completion(true)
            }
        }
        dataTask.resume()
    }
    
}

















