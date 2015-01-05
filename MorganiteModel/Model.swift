//
//  Model.swift
//  MorganiteModel
//
//  Created by Shigure Shimotori on 1/3/15.
//  Copyright (c) 2015 Shigure Shimotori. All rights reserved.
//

import Foundation
import CoreData

class Model: NSManagedObject {

    @NSManaged var someDataB: NSNumber
    @NSManaged var someDataA: String
}
