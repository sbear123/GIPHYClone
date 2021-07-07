//
//  imgCell.swift
//  GIPHYClone
//
//  Created by 박지현 on 2021/07/05.
//

import UIKit
import AVKit

class imgCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
    var player = AVPlayer()
    var playerLayer = AVPlayerLayer()
    
    override func prepareForReuse() {
        super.prepareForReuse()

        player.pause()
        playerLayer.removeFromSuperlayer()
        imgView.image = nil
    }
    
    func update(img: Mp4Images, width: Double) {
        let size = newSize(img: img, width: width)
        imgView.frame.size = size
        self.frame.size = size
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        guard let videoURL = URL(string: img.mp4) else {
            return
        }
        player = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = imgView.frame
        imgView.layer.addSublayer(playerLayer)
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { notification in
            let t1 = CMTimeMake(value: 60, timescale: 600);
            self.player.seek(to: t1)
            self.player.play()
        }
        player.play()
    }
    
    func newSize(img: Mp4Images, width: Double) -> CGSize {
        let imgWidth = Double(img.width)!
        let imgHeight = Double(img.height)!
        let ratio = width / imgWidth
        let newHeight = imgHeight * ratio
        return CGSize(width: width, height: newHeight)
    }
}
