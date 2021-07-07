//
//  ImageData.swift
//  GIPHYClone
//
//  Created by 박지현 on 2021/07/06.
//

import Foundation

struct GifData: Codable {
    var url: String
    var width: String
    var height: String
    var mp4: String
    var mp4Size: String
    
    enum CodingKeys: String, CodingKey {
        case url, width, height, mp4
        case mp4Size = "mp4_size"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = (try? values.decode(String.self, forKey: .url)) ?? ""
        width = (try? values.decode(String.self, forKey: .width)) ?? ""
        height = (try? values.decode(String.self, forKey: .height)) ?? ""
        mp4 = (try? values.decode(String.self, forKey: .mp4)) ?? ""
        mp4Size = (try? values.decode(String.self, forKey: .mp4Size)) ?? ""
    }
    
    init() {
        url = ""
        width = ""
        height = ""
        mp4 = ""
        mp4Size = ""
    }
}
