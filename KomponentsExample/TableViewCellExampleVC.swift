////
////  TableViewCellExampleVC.swift
////  KomponentsExample
////
////  Created by Sacha Durand Saint Omer on 01/05/2017.
////  Copyright © 2017 Octopepper. All rights reserved.
////
//
//import UIKit
//
//class TableViewCellExampleVC: UITableViewController {
//    
//    let entries = Array(1...100).map { "\($0) entry" }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.register(MyCell.self, forCellReuseIdentifier: "MyCell")
//        tableView.estimatedRowHeight = 44.0 // Auto-sizing cells
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return entries.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
//        let entry = entries[indexPath.row]
//        if var cell = cell as? MyCell  {
//            cell.updateProps(newProps: entry)
//            
//            if cell.isDirty {
//                cell.refresh()
//            }
//        }
//        return cell
//    }
//}
//
//
