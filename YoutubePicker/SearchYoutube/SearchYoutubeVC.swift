//
//  SearchYoutubeVC.swift
//  YoutubePlayer
//
//  Created by 新納真次郎 on 2018/07/05.
//  Copyright © 2018年 nshhhin. All rights reserved.
//

import UIKit
import SwiftyJSON
import youtube_ios_player_helper
import Alamofire

class SearchYoutubeVC: UIViewController {
    
    @IBOutlet weak var searchBox: UISearchBar!
    var searchBoxQuery = ""
    var results: Results!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var apiKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBox.delegate = self
        apiKey = appDelegate.apiKey
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var searchResultCollectionV: UICollectionView! {
        didSet {
            searchResultCollectionV.delegate = self
            searchResultCollectionV.dataSource = self
            searchResultCollectionV.register(cellType: SearchResultCell.self)
            searchResultCollectionV.backgroundColor = UIColor.clear
        }
    }
    
}
