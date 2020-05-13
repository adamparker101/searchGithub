//
//  SearchRepoItem.swift
//  SearchTest
//
//  Created by Adam Parker on 12/05/2020.
//  Copyright © 2020 Adam Parker. All rights reserved.
//

import Foundation

public class SearchRepoItem: Codable {
    public var name : String?
    public let full_name : String?
    public let forks_count : Int?
    public let open_issues_count : Int?
    public var description : String?
    public var url : String?
    public var updated_at : String?
    public var pushed_at : String?
}

enum CodingKeys: String, CodingKey {
    case name
    case full_name
    case forks_count
    case open_issues_count
    case description
    case url
    case updated_at
    case pushed_atpushed_at
}
