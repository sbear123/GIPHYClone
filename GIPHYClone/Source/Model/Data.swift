//
//  Data.swift
//  GIPHYClone
//
//  Created by 박지현 on 2021/07/05.
//

import Foundation

struct Data: Codable {
    var list: [Datum]
    var pagination: Pagination
    var meta: Meta
    
    enum CodingKeys: String, CodingKey {
        case list = "data"
        case pagination, meta
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        list = (try? values.decode([Datum].self, forKey: .list)) ?? []
        pagination = (try? values.decode(Pagination.self, forKey: .pagination)) ?? Pagination()
        meta = (try? values.decode(Meta.self, forKey: .meta)) ?? Meta()
    }
    
    init() {
        list = []
        pagination = Pagination()
        meta = Meta()
    }
}
