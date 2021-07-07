//
//  DownsizedSmall.swift
//  GIPHYClone
//
//  Created by 박지현 on 2021/07/05.
//

import Foundation

struct Mp4Images: Codable {
    var height, width, mp4Size: String
    var mp4: String

    enum CodingKeys: String, CodingKey {
        case height, width
        case mp4Size = "mp4_size"
        case mp4
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        height = (try? values.decode(String.self, forKey: .height)) ?? ""
        width = (try? values.decode(String.self, forKey: .width)) ?? ""
        mp4Size = (try? values.decode(String.self, forKey: .mp4Size)) ?? ""
        mp4 = (try? values.decode(String.self, forKey: .mp4)) ?? ""
    }
    
    init() {
        height = ""
        width = ""
        mp4Size = ""
        mp4 = ""
    }
}
