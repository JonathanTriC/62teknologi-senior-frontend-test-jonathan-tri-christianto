//
//  ReviewsModel.swift
//  Yelp
//
//  Created by JonathanTriC on 17/06/23.
//

import Foundation

// MARK: - ReviewsModel
struct ReviewsModel: Codable {
    let reviews: [Review]
    let total: Int
    let possibleLanguages: [String]

    enum CodingKeys: String, CodingKey {
        case reviews, total
        case possibleLanguages = "possible_languages"
    }
}

// MARK: - Review
struct Review: Codable, Identifiable {
    let id: String
    let url: String
    let text: String
    let rating: Double
    let timeCreated: String
    let user: User

    enum CodingKeys: String, CodingKey {
        case id, url, text, rating
        case timeCreated = "time_created"
        case user
    }
}

// MARK: - User
struct User: Codable {
    let id: String
    let profileURL: String
    let imageURL: String?
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case profileURL = "profile_url"
        case imageURL = "image_url"
        case name
    }
}
