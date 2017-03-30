//
//  ViewController.swift
//  React
//
//  Created by Sacha Durand Saint Omer on 29/03/2017.
//  Copyright © 2017 Freshos. All rights reserved.
//

import UIKit

//class ViewController: UITableViewController {
//    
//    var photos: [Photo] = [
//        Photo(title: "1", detail: "1", numberOfYummys: 34, numberOfcomments: 2),
//        Photo(title: "2", detail: "2", numberOfYummys: 56, numberOfcomments: 85),
//        Photo(title: "3", detail: "3", numberOfYummys: 46, numberOfcomments: 23)
//    ]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // tableView.rowHeight = UITableViewAutomaticDimension // Optional??
//        tableView.estimatedRowHeight = 700
//        tableView.reloadData()
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return photos.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let photo = photos[indexPath.row]
//        let component = PhotoFeedCell.new(with: photo)
//        let cell = UITableViewCell()
//        
//        let cView = component.render()
//        cView.translatesAutoresizingMaskIntoConstraints = false
//        cell.contentView.addSubview(cView)
//        cView.fillContainer()
//        
//        // how do we reuse?? existing layouts? / cells/
//        
//        return cell
//    }
//}



// TBV(component<M>, models)

//class ViewController: UITableViewController {
//    
//    var photos: [Photo] = [
//        Photo(title: "1", detail: "1", numberOfYummys: 34, numberOfcomments: 2),
//        Photo(title: "2", detail: "2", numberOfYummys: 56, numberOfcomments: 85),
//        Photo(title: "3", detail: "3", numberOfYummys: 46, numberOfcomments: 23)
//    ]
//    
//    func build100Photos() -> [Photo] {
//        return Array(1...100).map { i in
//            return Photo(title: "\(i)", detail: "1", numberOfYummys: 2*i, numberOfcomments: 3*i)
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        photos = build100Photos()
//        // tableView.rowHeight = UITableViewAutomaticDimension // Optional??
//        tableView.register(PhotoCell.self, forCellReuseIdentifier: "PhotoCell")
//        tableView.estimatedRowHeight = 700
//        tableView.reloadData()
//        
//        
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return photos.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotoCell {
//            if !cell.hasBeenRendered {
//                let photo = photos[indexPath.row]
//    
//                let component = PhotoFeedCell.new(with: photo)
//                
//                let cView = component.render()
//                cView.translatesAutoresizingMaskIntoConstraints = false
//                cell.contentView.addSubview(cView)
//                cView.fillContainer()
//                
//                cell.hasBeenRendered = true
//            }
//            return cell
//        }
//        
//
//        //find a way to fil the good data  only ?
//
//        // how do we reuse?? existing layouts? / cells/
//        return UITableViewCell()
//    }
//}
//
//class PhotoCell: UITableViewCell {
//    var hasBeenRendered = false
//    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        selectionStyle = .none
//        print("Building cell")
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
