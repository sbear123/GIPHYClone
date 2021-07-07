//
//  DetailViewController.swift
//  GIPHYClone
//
//  Created by 박지현 on 2021/07/05.
//

import UIKit

class DetailViewController: UITableViewController, UserCellDelegate {
    
    @IBOutlet var table: UITableView!
    
    let vm: DetailViewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
    }
    
    func didTapFavorite(cell: UserCell) {
        let imageName = vm.tapFavorite() ? "heart.fill" : "heart"
        cell.favorite.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = vm.gifData else {
            return UITableViewCell()
        }
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "gifCell", for: indexPath) as! GifCell
            
            cell.selectionStyle = .none
            let width = self.view.frame.width
            let height = vm.getNewHeight(self.view.frame.width)
            table.rowHeight = height
            let size = CGSize(width: width, height: height)
            cell.update(gifUrl: data.images.fixedHeight.mp4, size: size)
            
            return cell
        }
        else {
            table.rowHeight = 80
            let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
            
            cell.selectionStyle = .none
            cell.update(data: data)
            cell.cellDelegate = self
            
            return cell
        }
    }
    
}
