//
//  TextedNumber+CoreDataProperties.swift
//  SMSProject
//
//  Created by Ade Adegoke on 16/04/2019.
//  Copyright © 2019 AKA. All rights reserved.
//
//

import Foundation
import CoreData


extension TextedNumber {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TextedNumber> {
        return NSFetchRequest<TextedNumber>(entityName: "TextedNumber")
    }

    @NSManaged public var phoneNumber: String?
    @NSManaged public var date: String?
    @NSManaged public var time: String?
    
}
