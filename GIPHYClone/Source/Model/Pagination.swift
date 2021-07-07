//
//  Pagination.swift
//  GIPHYClone
//
//  Created by 박지현 on 2021/07/05.
//

import Foundation

struct Pagination: Codable {
    var totalCount, count, offset: Int

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case count, offset
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalCount = (try? values.decode(Int.self, forKey: .totalCount)) ?? 0
        count = (try? values.decode(Int.self, forKey: .count)) ?? 0
        offset = (try? values.decode(Int.self, forKey: .offset)) ?? 0
    }
    
    init() {
        totalCount = 0
        count = 0
        offset = 0
    }
}
