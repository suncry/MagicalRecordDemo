//
//  DetailEntiry+CoreDataProperties.swift
//  MagicalRecordTest
//
//  Created by heyunpeng on 16/3/29.
//  Copyright © 2016年 heyunpeng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension DetailEntiry {

    @NSManaged var name: String?
    @NSManaged var containerEntity: NSManagedObject?

}
