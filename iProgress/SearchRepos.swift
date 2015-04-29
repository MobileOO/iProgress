//
//  SearchRepos.swift
//  iProgress
//
//  Created by Rafael Cavalcante Ferreira Santos Matos on 4/29/15.
//  Copyright (c) 2015 Eduardo Quadros. All rights reserved.
//

import UIKit
import CoreData

class SearchRepos: NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    
    var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var user: User!
    var result: NSArray!
    
    var name: String
    var password: String
    
    var userReposData: NSMutableArray!
    var xablau: NSMutableArray!
    var json: NSMutableData!
    var repos: NSMutableArray!
    
    class var sharedInstance : SearchRepos{
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : SearchRepos? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = SearchRepos()
        }
        return Static.instance!
    }
    
    private override init() {
    
        name = String()
        password = String()
        
        super.init()
        
    }
    func  searchRepos(){
        
        var fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.returnsObjectsAsFaults = false
        
        result = context!.executeFetchRequest(fetchRequest, error: nil)!
        
        user = result.objectAtIndex(0) as! User
        self.name = user.name
        self.password = user.password
        
        let loginString = NSString(format: "%@:%@", self.name, self.password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        // create the request
        let url = NSURL(string: "https://api.github.com/users/\(self.name)/repos")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        // fire off the request
        // make sure your class conforms to NSURLConnectionDelegate
        let connection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        connection?.start()
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        self.json?.appendData(data)
        
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        self.json = NSMutableData()
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        self.userReposData = NSJSONSerialization.JSONObjectWithData(self.json, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSMutableArray
        
        self.repos = NSMutableArray()
        
        for i in 0..<(userReposData.count) {
            var repo = userReposData[i] as! NSMutableDictionary
            var name = repo.valueForKey("url") as! String
            repos.addObject(name)
        }
        
        
    }
}
