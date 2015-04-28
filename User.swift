//
//  User.swift
//  iProgress
//
//  Created by Isaías Lima on 28/04/15.
//  Copyright (c) 2015 Eduardo Quadros. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var password: String

}
