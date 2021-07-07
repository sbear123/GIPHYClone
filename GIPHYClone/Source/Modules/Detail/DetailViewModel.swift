//
//  DetailViewModel.swift
//  GIPHYClone
//
//  Created by 박지현 on 2021/07/06.
//

import Foundation
import UIKit

class DetailViewModel {
    var gifData: Datum?
    
    func getNewHeight(_ vWidth: CGFloat) -> CGFloat {
        guard let data = gifData else {
            return CGFloat()
        }
        let gif = data.images.fixedHeight
        guard let width = Int(gif.width) else {
            return CGFloat()
        }
        guard let height = Int(gif.height) else {
            return CGFloat()
        }
        let ratio = vWidth / CGFloat(width)
        let newHeight = CGFloat(height) * ratio
        return newHeight
    }
    
    func tapFavorite() -> Bool {
        guard let data = gifData else {
            return false
        }
        let id = data.id
        if UserDefaults.standard.string(forKey: id) == nil {
            UserDefaults.standard.set(true, forKey: id)
            return true
        }
        UserDefaults.standard.removeObject(forKey: id)
        return false
    }
    
}
