//
//  MiniBusText+CoreDataProperties.swift
//  MiniBus
//
//  Created by kenkan on 14/1/2022.
//
//

import Foundation
import CoreData


extension MiniBusText {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MiniBusText> {
        return NSFetchRequest<MiniBusText>(entityName: "MiniBusText")
    }

    @NSManaged public var texteng: String?
    @NSManaged public var textzhone: String?
    @NSManaged public var textzhtwo: String?

}

extension MiniBusText : Identifiable {

}
