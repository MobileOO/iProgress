//
//  Search.swift
//  iProgress
//
//  Created by Isaías Lima on 28/04/15.
//  Copyright (c) 2015 Eduardo Quadros. All rights reserved.
//

import UIKit

class Search: NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    
    var name: String
    var password: String
    
    
    var jsonData: NSMutableData!
    var userData: NSDictionary!
    
    class var sharedInstance : Search{
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : Search? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = Search()
        }
        return Static.instance!
    }
    
    private override init() {
        
        name = String()
        password = String()
        
        super.init()
        
    }
    
    func connect() {
        
        let loginString = NSString(format: "%@:%@", self.name, self.password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        // create the request
        let url = NSURL(string: "https://api.github.com/user")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        // fire off the request
        // make sure your class conforms to NSURLConnectionDelegate
        let urlConnection = NSURLConnection(request: request, delegate: self)
        urlConnection?.start()
        
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        self.jsonData?.appendData(data)
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        self.jsonData = NSMutableData()
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        self.userData = NSJSONSerialization.JSONObjectWithData(self.jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        connection.finalize()
    }
    
}
