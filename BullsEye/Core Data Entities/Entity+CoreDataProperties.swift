//
//  Entity+CoreDataProperties.swift
//  BullsEye
//
//  Created by Tian Tong on 2020/5/29.
//  Copyright © 2020 TTDP. All rights reserved.
//
//

import Foundation
import CoreData

extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var value: String

}
