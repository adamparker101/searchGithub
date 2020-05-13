//
//  SearchRepoResponse.swift
//  SearchTest
//
//  Created by Adam Parker on 12/05/2020.
//  Copyright © 2020 Adam Parker. All rights reserved.
//

import Foundation

class SearchRepoResponse: Codable {

    public let incompleteResults : Bool?
    public let items : [SearchRepoItem]?
    public let totalCount : Int?

    enum CodingKeys: String, CodingKey {
        case incompleteResults = "incomplete_results"
        case items
        case totalCount = "total_count"
    }
    
}
