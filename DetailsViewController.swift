//
//  DetailsViewController.swift
//  iProgress
//
//  Created by Rafael Cavalcante Ferreira Santos Matos on 4/30/15.
//  Copyright (c) 2015 Eduardo Quadros. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var nomeRepo: UILabel!
    @IBOutlet weak var lingRepo: UILabel!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func push() {
        self.performSegueWithIdentifier("xablau", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
