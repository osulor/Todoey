//
//  Item.swift
//  Todoey
//
//  Created by Mubarak Akinbola on 2/6/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
   @objc dynamic var title: String = ""
   @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    //Create relationship (inverse relationship that link each item back to
    //to a parent category)
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
