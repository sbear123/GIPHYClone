//
//  FixedHeight.swift
//  GIPHYClone
//
//  Created by 박지현 on 2021/07/05.
//

import Foundation

struct FixedImages: Codable {
    var height, width, size: String
    var url: String
    var mp4Size: String?
    var mp4: String?
    var webpSize: String
    var webp: String
    var frames, hash: String?

    enum CodingKeys: String, CodingKey {
        case height, width, size, url
        case mp4Size = "mp4_size"
        case mp4
        case webpSize = "webp_size"
        case webp, frames, hash
    }
}
