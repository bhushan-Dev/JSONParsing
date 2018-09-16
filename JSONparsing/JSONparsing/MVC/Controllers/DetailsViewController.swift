//
//  DetailsViewController.swift
//  JSONparsing
//
//  Created by Bhushan Udawant on 16/09/18.
//  Copyright © 2018 Bhushan Udawant. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var dict: Dictionary<String, Any?>?
    
    
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let dict = dict, let title = dict["title"] as? String,
            let description = dict["body"] as? String,
            let userID = dict["userId"] as? Int {
            self.userId.text = String(format: "%d", userID)
            self.userTitle.text = title
            self.userDescription.text = description
            navigationItem.title = title
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
