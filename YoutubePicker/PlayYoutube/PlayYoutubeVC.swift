//
//  ViewController.swift
//  YoutubePlayer
//
//  Created by 新納真次郎 on 2018/07/05.
//  Copyright © 2018年 nshhhin. All rights reserved.
//

import UIKit
import SwiftyJSON
import youtube_ios_player_helper
import Alamofire
import AVFoundation

class PlayYoutubeVC: UIViewController, YTPlayerViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playerView: YTPlayerView!
    var result: Result!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerView.delegate = self;
        playerView.layer.cornerRadius = 30
        titleLabel.text = result.title
        setYoutubePlayer(vid: result.vid)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.playerView?.playVideo()
    }
    
    @IBAction func tapSelect(_ sender: Any) {
        let destinationVC = R.storyboard.searchYoutube.instantiateInitialViewController()
        present(destinationVC!, animated: true, completion: nil)
    }

    @IBAction func tapPlay(_ sender: Any) {
        self.playerView.playVideo()
    }
    
    @IBAction func tapPause(_ sender: Any) {
        self.playerView.pauseVideo()
    }
    
    @IBAction func tapRewind(_ sender: Any) {
        self.playerView.seek(toSeconds: 0, allowSeekAhead: true)
    }
    
    @IBAction func tapSkip(_ sender: Any) {
        updateYoutubePlayer()
    }
    
    func setYoutubePlayer(vid: String){
        self.playerView.load(withVideoId: vid, playerVars: ["playsinline":1,"controls":0, "origin": "https://www.youtube.com/"])
    }
   
    // プレイヤーをじゅんきデータベースAPIをもとに更新
    func updateYoutubePlayer(){
        Alamofire.request("https://nino.nkmr.io/junkiMusicList.php").responseString(completionHandler: { response in
            let json = JSON(response.data!)
            let name = json["name"].string
            let vid  = json["vid"].string
            self.titleLabel.text = name
            print( "name:", name!, "vid:", vid!)
            self.playerView.load(withVideoId: "NY0xJLnoCXE", playerVars: ["playsinline":1,"controls":0, "origin": "https://www.youtube.com/"])
            self.playerView.isHidden = true
        })
    }
    
}

