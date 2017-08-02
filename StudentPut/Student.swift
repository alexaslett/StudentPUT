//
//  Student.swift
//  StudentPut
//
//  Created by Alex Aslett on 8/2/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation

struct Student {
    
    let name: String
    
}

// MARK: - JSON Coversion

extension Student {
    
    private static var nameKey: String { return "name" }
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary[Student.nameKey] as? String else { return nil }
        self.init(name: name)
        
    }
    // Nedd a failable initializer to create a student from a dictionary
    var dictionaryRepresentation: [String: Any] {
        return [Student.nameKey: name]
    }
    
    // dictionaryRepresentation
    // jsonData/Represenation to be able to post to the API
    
    var jsonData: Data? {
        return (try? JSONSerialization.data(withJSONObject: dictionaryRepresentation, options: .prettyPrinted))
    }
    
    
}



