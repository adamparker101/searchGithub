//
//  SavedSearchItem.swift
//  SearchTest
//
//  Created by Adam Parker on 12/05/2020.
//  Copyright © 2020 Adam Parker. All rights reserved.
//

import Foundation
import CoreData

struct SavedSearchItem : Identifiable
{
    var id: NSManagedObjectID
    var searchText: String
}
