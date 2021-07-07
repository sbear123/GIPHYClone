//
//  MainViewModel.swift
//  GIPHYClone
//
//  Created by 박지현 on 2021/07/06.
//

import UIKit

class MainViewModel {
    let service: APIManager = APIManager()
    var data: Data = Data()
    var searchType: String = "gifs"
    var searchText: String = ""
    
    func listCnt() -> Int {
        return data.list.count
    }
    
    func getPreView(cnt: Int) -> Mp4Images {
        return data.list[cnt].images.preview
    }
    
    func changeSearchType() {
        searchType = searchType == "gifs" ? "stickers" : "gifs"
    }
    
    func getList(handler: @escaping (Bool, String?) -> Void) {
        searchText = ""
        let param = service.makeTrendingParam(cnt: 0)
        service.getTrending(type: searchType, param: param) { data, success in
            let result = self.resetData(data: data, success: success)
            handler(result.0, result.1)
        }
    }
    
    func fetchList(handler: @escaping (Bool, String?) -> Void) {
        let param = service.makeTrendingParam(cnt: data.list.count)
        service.getTrending(type: searchType, param: param) { data, success in
            let result = self.fetchData(new: data, success: success)
            handler(result.0, result.1)
        }
    }
    
    func searchList(query: String, handler: @escaping (Bool, String?) -> Void) {
        searchText = query
        let param = service.makeParam(query: query, cnt: 0)
        service.getSearch(type: searchType, param: param) { data, success in
            let result = self.resetData(data: data, success: success)
            handler(result.0, result.1)
        }
    }
    
    func fetchSearchList(handler: @escaping (Bool, String?) -> Void) {
        let param = service.makeParam(query: searchText, cnt: data.list.count)
        service.getSearch(type: searchType, param: param) { data, success in
            let result = self.fetchData(new: data, success: success)
            handler(result.0, result.1)
        }
    }
    
    func fetchData(new: Data, success: Bool) -> (Bool, String?) {
        if success {
            if data.pagination.count == 0 {
                return (false, "더 이상 데이터를 불러 올 수 없습니다.")
            }
            data.meta = new.meta
            data.pagination = new.pagination
            data.list += new.list
            return (true, nil)
        }
        return (false, data.meta.msg)
    }
    
    func resetData(data: Data, success: Bool) -> (Bool, String?) {
        if success {
            if data.pagination.count == 0 {
                return (false, "검색결과가 없습니다.")
            }
            self.data = data
            return (true, nil)
        }
        return (false, data.meta.msg)
    }
    
    func getNewHeight(img: Mp4Images, cellWidth: Double) -> CGFloat {
        let imgWidth = Double(img.width)!
        let imgHeight = Double(img.height)!
        let ratio = cellWidth / imgWidth
        return CGFloat(imgHeight * ratio)
    }
}
