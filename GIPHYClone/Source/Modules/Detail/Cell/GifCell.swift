//
//  ImageCell.swift
//  GIPHYClone
//
//  Created by 박지현 on 2021/07/06.
//

import UIKit
import AVKit

class GifCell: UITableViewCell {
    @IBOutlet weak var gifView: UIImageView!
    
    var player = AVPlayer()
    var playerLayer = AVPlayerLayer()
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func update(gifUrl: String, size: CGSize) {
        gifView.frame.size = size
        self.frame.size = size
        let videoURL = URL(string: gifUrl)
        player = AVPlayer(url: videoURL!)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = gifView.frame
        gifView.layer.addSublayer(playerLayer)
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { notification in
            let t1 = CMTimeMake(value: 60, timescale: 600);
            self.player.seek(to: t1)
            self.player.play()
        }
        player.play()
    }
}
