//
//  ReminderTableViewController.swift
//  DO IT
//
//  Created by Cedric Bahirwe on 8/1/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import UIKit

class ReminderTableViewController: UITableViewController {
    var data  = [1,2,3,4,5,6,7,8,9,0,1,423,23,5,35,43,6,6,457,45,756,78,45,745]
var fetchigMore = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.parent?.tabBarItem.badgeValue = data.count.description
        self.tableView.rowHeight = UITableView.automaticDimension;
        self.tableView.estimatedRowHeight = 80;
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelectionDuringEditing = true
        
        
        let loadingNib = UINib(nibName: "LoadingCell", bundle: nil)
        self.tableView.register(loadingNib, forCellReuseIdentifier: "LoadingCell")

//         Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = true

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    @IBAction func didpressDelete(_ sender: UIBarButtonItem) {
//        self.isEditing = !self.isEditing
        if let selectedRows = tableView.indexPathsForSelectedRows {
            var items = [Int]()
            for indexPath in selectedRows {
                items.append(data[indexPath.row])
            }
            for item in items {
                if let index = data.firstIndex(of: item) {
                    data.remove(at: index)
                }
            }
            
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .fade)
            tableView.endUpdates()
        }
        
    }
    
    
    @IBAction func didPressEdit(_ sender: UIBarButtonItem) {
        isEditing = !isEditing
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return data.count
        
        
        return section == 0 ? data.count : section == 1  && fetchigMore ? 1 : 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderTableViewCell", for: indexPath) as? ReminderTableViewCell else { return UITableViewCell() }
                    
            cell.remindLabel.text = "\(data[indexPath.row])"
            cell.remindDateLabel.text =  "The reminder No. \(data[indexPath.row])"
            return cell
        } else {
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as? LoadingCell else { return UITableViewCell() }
             cell.spinner.startAnimating()

             return cell
            
        }
        
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offSetY > contentHeight - scrollView.frame.height * 3 {
            if !fetchigMore {
                beginBatchFetch()
            }
        }
    }
    
    func beginBatchFetch() {
        fetchigMore = true
        tableView.reloadSections(IndexSet(integer: 1), with: .none)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let newData = (self.data.count...self.data.count + 10).map{ index in index }
            self.data.append(contentsOf: newData)
            self.fetchigMore = false
            self.tableView.reloadData()
        }

    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
