//
//  LabelCell.swift
//  GIPHYClone
//
//  Created by 박지현 on 2021/07/06.
//

import UIKit

protocol UserCellDelegate: AnyObject {
    func didTapFavorite(cell: UserCell)
}

class UserCell: UITableViewCell {
    @IBOutlet weak var avatorImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var favorite: UIButton!
    
    weak var cellDelegate: UserCellDelegate?
    
    @IBAction func TapFavorite(_ sender: Any) {
        cellDelegate?.didTapFavorite(cell: self)
    }
    
    func update(data: Datum){
        let user = data.user
        self.name.text = user.username
        let imageName = (UserDefaults.standard.string(forKey: data.id) != nil) ? "heart.fill" : "heart"
        favorite.setImage(UIImage(systemName: imageName), for: .normal)
        if user.avatarURL == "" {
            transition(toImage: UIImage(named: "UserImage"))
            return
        }
        URLSession.shared.dataTask(with: URL(string: user.avatarURL)!) { (data, response, err) in
            if let data = data {
                DispatchQueue.main.async {
                    self.transition(toImage: UIImage(data: data))
                }
            }
        }.resume()
    }
    
    func transition(toImage image: UIImage?) {
        UIView.transition(with: self, duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.avatorImg.image = image
                          },
                          completion: nil)
    }
}
