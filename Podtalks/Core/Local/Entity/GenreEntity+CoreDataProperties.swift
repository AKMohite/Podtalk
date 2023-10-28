//
//  GenreEntity+CoreDataProperties.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 28/10/23.
//
//

import Foundation
import CoreData


extension GenreEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenreEntity> {
        return NSFetchRequest<GenreEntity>(entityName: "GenreEntity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String
    @NSManaged public var parent_id: Int16

}

extension GenreEntity : Identifiable {

}
