//
//  GithubUser.swift
//  Demo
//
//  Created by Pablo Martinez Piles on 27/01/2023.
//

import Foundation


struct GithubUser: Decodable, Identifiable {
    let id: Int
    let type: String
    let login: String
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case login
        case avatarUrl = "avatar_url"
    }
}
