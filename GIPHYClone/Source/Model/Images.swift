//
//  Images.swift
//  GIPHYClone
//
//  Created by 박지현 on 2021/07/05.
//

import Foundation

struct Images: Codable {
    var fixedHeight: GifData
    var preview: Mp4Images
    
    enum CodingKeys: String, CodingKey {
        case preview
        case fixedHeight = "fixed_height"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fixedHeight = (try? values.decode(GifData.self, forKey: .fixedHeight)) ?? GifData()
        preview = (try? values.decode(Mp4Images.self, forKey: .preview)) ?? Mp4Images()
    }
    
    init() {
        preview = Mp4Images()
        fixedHeight = GifData()
    }
    
}
