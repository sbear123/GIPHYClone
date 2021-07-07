//
//  User.swift
//  GIPHYClone
//
//  Created by 박지현 on 2021/07/05.
//

import Foundation

struct User: Codable {
    var avatarURL: String
    var profileURL: String
    var username: String
    var displayName: String
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case profileURL = "profile_url"
        case username
        case displayName = "display_name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avatarURL = (try? values.decode(String.self, forKey: .avatarURL)) ?? ""
        profileURL = (try? values.decode(String.self, forKey: .profileURL)) ?? ""
        username = (try? values.decode(String.self, forKey: .username)) ?? ""
        displayName = (try? values.decode(String.self, forKey: .displayName)) ?? ""
    }
    
    init() {
        avatarURL = ""
        profileURL = ""
        username = ""
        displayName = ""
    }
}
