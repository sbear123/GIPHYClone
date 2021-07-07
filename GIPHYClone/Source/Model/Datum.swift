//
//  Datum.swift
//  GIPHYClone
//
//  Created by 박지현 on 2021/07/05.
//

import Foundation

struct Datum: Codable {
    var id: String
    var images: Images
    var user: User

    enum CodingKeys: String, CodingKey {
        case id
        case images, user
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(String.self, forKey: .id)) ?? ""
        images = (try? values.decode(Images.self, forKey: .images)) ?? Images()
        user = (try? values.decode(User.self, forKey: .user)) ?? User()
    }
}
