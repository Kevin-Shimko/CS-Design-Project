//
//  FirstViewController.swift
//  Project-Prophecy
//
//  Created by Kevin Shimko on 2/26/19.
//  Copyright © 2019 KSS. All rights reserved.
// 

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocol {
    
    var feedItems: NSArray = NSArray()
    var selectedMovie : MovieModel = MovieModel()
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
    }
    
    func itemsDownload(items: NSArray) {
        feedItems = items
        self.listTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        let cellIdentifier: String = "BasicCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the location to be shown
        let item: MovieModel = feedItems[indexPath.row] as! MovieModel
        // Get references to labels of cell
        myCell.textLabel!.text = item.title
        
        return myCell
    }
    
}

