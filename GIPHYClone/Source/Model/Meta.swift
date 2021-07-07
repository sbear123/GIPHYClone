//
//  Meta.swift
//  GIPHYClone
//
//  Created by 박지현 on 2021/07/05.
//

import Foundation

struct Meta: Codable {
    var status: Int
    var msg, responseID: String

    enum CodingKeys: String, CodingKey {
        case status, msg
        case responseID = "response_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? 0
        msg = (try? values.decode(String.self, forKey: .msg)) ?? ""
        responseID = (try? values.decode(String.self, forKey: .responseID)) ?? ""
    }
    
    init() {
        status = 0
        msg = ""
        responseID = ""
    }
}
