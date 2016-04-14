//
//  FriendListViewController.swift
//  Patterns
//
//  Created by Mathias Iden on 14.04.2016.
//  Copyright © 2016 TDT4240G12. All rights reserved.
//

import UIKit

class FriendListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let friendCellIdentifier = "FriendCell"
    var dataSource = staticFriendList
    var inputFieldInAlertView: UITextField = UITextField()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var friendsCountLabel: UILabel!
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    func dataDidChange(){
        friendsCountLabel.text = String(dataSource.count)
        self.tableView.reloadData();
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 76;
        friendsCountLabel.text = String(dataSource.count)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(friendCellIdentifier) as! FriendCellTableViewCell
        let username = dataSource[indexPath.row]
        cell.configureCell(username)
        cell.userInteractionEnabled = false
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func addFriendTapped(sender: AnyObject) {
        let alertController = UIAlertController(title: "Add Friend", message: "Enter friends username", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addTextFieldWithConfigurationHandler { (UITextField) in
            self.inputFieldInAlertView = UITextField;
            self.inputFieldInAlertView.placeholder = "Username"
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
            print("Trykket add")
            self.dataSource.append(self.inputFieldInAlertView.text!)
            self.dataDidChange();
            print(self.inputFieldInAlertView.text!)
        }))
        self.presentViewController(alertController, animated: true) {
            // Do something when alert view is shown.
        }
        
    }
    
}