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
}
