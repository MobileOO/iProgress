//
//  ProfileViewController.swift
//  iProgress
//
//  Created by Isaías Lima on 28/04/15.
//  Copyright (c) 2015 Eduardo Quadros. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UITableViewController {
    
    @IBOutlet var photo: UIImageView!
    var avatar: UIImage!
    var search: Search!
    var searchRepos: SearchRepos!
    var userData: NSDictionary!
    @IBOutlet var nick: UILabel!
    @IBOutlet var followers: UILabel!
    @IBOutlet var following: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        search = Search.sharedInstance
        userData = search.userData
        searchRepos = SearchRepos.sharedInstance
                
        var avatarURL = String()
        avatarURL = userData.objectForKey("avatar_url") as! String
        
        var data = NSData(contentsOfURL: NSURL(string: avatarURL)!)
        
        avatar = UIImage(data: data!)
        
        photo.image = avatar
        photo.layer.masksToBounds = true
        photo.layer.cornerRadius = 20
        
        nick.text = userData.objectForKey("login") as? String
        
        var follow = userData.objectForKey("followers") as! Int
        followers.text = "\(follow)"
        
        var followed = userData.objectForKey("following") as! Int
        following.text = "\(followed)"
    }
    
    override func viewDidAppear(animated: Bool) {
        searchRepos.searchRepos()
    }
    
    @IBAction func github(sender: AnyObject) {
        var user = userData.objectForKey("login") as! String
        var url = "https://www.github.com/\(user)"
        
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

/*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }
*/

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
