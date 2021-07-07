//
//  APIManager.swift
//  GIPHYClone
//
//  Created by 박지현 on 2021/07/05.
//

import Foundation
import Alamofire

class APIManager: BaseAPI {
    func makeParam(query: String, cnt: Int) -> Dictionary<String,Any> {
        var param: Dictionary<String,Any> = [:]
        param.updateValue(apiKey, forKey: "api_key")
        param.updateValue(query, forKey: "q")
        param.updateValue(20, forKey: "limit")
        param.updateValue(cnt, forKey: "offset")
        param.updateValue("g", forKey: "rating")
        return param
    }
    
    func makeTrendingParam(cnt: Int) -> Dictionary<String,Any> {
        var param: Dictionary<String,Any> = [:]
        param.updateValue(apiKey, forKey: "api_key")
        param.updateValue(20, forKey: "limit")
        param.updateValue(cnt, forKey: "offset")
        param.updateValue("g", forKey: "rating")
        return param
    }
    
    func getSearch(type: String, param: Dictionary<String,Any>, handler: @escaping (Data, Bool) -> Void) {
        AF.request(self.baseURL + "\(type)/search",
                   method: .get,
                   parameters: param,
                   encoding: URLEncoding.queryString)
            .validate(statusCode: 200..<400)
            .responseJSON{ response in
                switch response.result {
                case .success(let value):
                    if let dic = value as? NSDictionary {
                        do {
                            let dataJSON = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                            let data = try JSONDecoder().decode(Data.self, from: dataJSON)
                            handler(data, true)
                        }
                        catch {
                            handler(Data(), false)
                            print(error.localizedDescription)
                        }
                    }
                case .failure(let err):
                    handler(Data(), false)
                    print(err)
                }
            }
    }
    
    func getTrending(type: String, param: Dictionary<String,Any>, handler: @escaping (Data, Bool) -> Void) {
        AF.request(self.baseURL + "\(type)/trending",
                   method: .get,
                   parameters: param,
                   encoding: URLEncoding.queryString)
            .validate(statusCode: 200..<400)
            .responseJSON{ response in
                switch response.result {
                case .success(let value):
                    if let dic = value as? NSDictionary {
                        do {
                            let dataJSON = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                            let data = try JSONDecoder().decode(Data.self, from: dataJSON)
                            handler(data, true)
                        }
                        catch {
                            var data = Data()
                            var meta = Meta()
                            meta.msg = "서버에서 값을 받아오지 못하고 있습니다."
                            meta.status = 400
                            data.meta = meta
                            handler(data, false)
                            print(error.localizedDescription)
                        }
                    }
                case .failure(let err):
                    var data = Data()
                    var meta = Meta()
                    meta.msg = "서버에서 값을 받아오지 못하고 있습니다."
                    meta.status = err.responseCode!
                    data.meta = meta
                    handler(Data(), false)
                    print(err)
                }
            }
    }
    
}
