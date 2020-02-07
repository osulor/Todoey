//
//  Category.swift
//  Todoey
//
//  Created by Mubarak Akinbola on 2/6/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    //Relationsip with items, saying each category can have a number of times
    let items = List<Item>()
}
