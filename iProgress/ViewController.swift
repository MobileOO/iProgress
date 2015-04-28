//
//  ViewController.swift
//  iProgress
//
//  Created by Eduardo Quadros on 4/27/15.
//  Copyright (c) 2015 Eduardo Quadros. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    var search: Search!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        search = Search.sharedInstance
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "profile", name: "segue", object: nil)
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func login(sender: AnyObject) {
        
        search.name = username.text
        search.password = password.text
        search.connect()
    }
    
    func profile() {
        self.performSegueWithIdentifier("xablau", sender: self)
    }
}

