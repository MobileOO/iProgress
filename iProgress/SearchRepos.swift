//
//  SearchRepos.swift
//  iProgress
//
//  Created by Rafael Cavalcante Ferreira Santos Matos on 4/29/15.
//  Copyright (c) 2015 Eduardo Quadros. All rights reserved.
//

import UIKit

class SearchRepos: NSObject {
    
    var search: Search!
    var userData: NSDictionary!
    
    var jsonData: NSMutableData!
    
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
    
        
        super.init()
        
    }
    func  searchRepos(){
        
        search = Search.sharedInstance
        
        let loginString = NSString(format: "%@:%@", search.name, search.password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        // create the request
        let url = NSURL(string: "https://api.github.com/user/repos")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        // fire off the request
        // make sure your class conforms to NSURLConnectionDelegate
        let urlConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        urlConnection?.start()
    }
    func connectionRepos(connection: NSURLConnection, didReceiveData data: NSData) {
        self.jsonData?.appendData(data)
    }
    
    func connectionRepos(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        self.jsonData = NSMutableData()
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        self.userData = NSJSONSerialization.JSONObjectWithData(self.jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        //let notificantionCenter = NSNotificationCenter.defaultCenter()
        //notificantionCenter.postNotificationName("segue", object: self)
        
    }
}
