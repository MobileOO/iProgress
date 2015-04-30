//
//  Filter.swift
//  iProgress
//
//  Created by Isaías Lima on 30/04/15.
//  Copyright (c) 2015 Eduardo Quadros. All rights reserved.
//

import UIKit
import CoreData
    
class Filter: NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    
    var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var user: User!
    var result: NSArray!
    
    var name: String
    var password: String
    
    var jsonData: NSMutableData!
    var repoData: NSDictionary!
    
    var mackRepos: NSMutableArray!
    
    var searchRepos: SearchRepos!
    
    var i = 0
    
    class var sharedInstance : Filter {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : Filter? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = Filter()
        }
        return Static.instance!
    }
    
    private override init() {
        
        name = String()
        password = String()
        mackRepos = NSMutableArray()
        searchRepos = SearchRepos.sharedInstance
        
        super.init()
    }
    
    func repoConnect() {
        
        var fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.returnsObjectsAsFaults = false
        
        result = context!.executeFetchRequest(fetchRequest, error: nil)!
        
        user = result.objectAtIndex(0) as! User
        self.name = user.name
        self.password = user.password
        
        let loginString = NSString(format: "%@:%@", self.name, self.password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        let url = NSURL(string: searchRepos.repos.objectAtIndex(i) as! String)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
            
        // fire off the request
        // make sure your class conforms to NSURLConnectionDelegate
        let urlConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        urlConnection?.start()
        i++

        
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        self.jsonData?.appendData(data)
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        self.jsonData = NSMutableData()
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        self.repoData = NSJSONSerialization.JSONObjectWithData(self.jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        if repoData.valueForKey("parent") != nil {
            
            var parent = repoData.valueForKey("parent") as! NSMutableDictionary
            var owner = parent.valueForKey("owner") as! NSMutableDictionary
            var login = owner.valueForKey("login") as! String
            
            if login == "mackmobile" {
                mackRepos.addObject(repoData.valueForKey("name") as! String)
            }
            
        }
        
        if i < searchRepos.repos.count {
            self.repoConnect()
        } else {
            let notificantionCenter = NSNotificationCenter.defaultCenter()
            notificantionCenter.postNotificationName("reload", object: self)
        }
        
    }
   //test
}
