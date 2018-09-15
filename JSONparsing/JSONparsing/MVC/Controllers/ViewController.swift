//
//  ViewController.swift
//  JSONParsing
//
//  Created by Bhushan Udawant on 15/09/18.
//  Copyright © 2018 Bhushan Udawant. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    private let strURL = "https://jsonplaceholder.typicode.com/posts"
    var arrayList: Array<Dictionary<String, Any?>?>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//
        callPostApi()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func callPostApi() {
        let url = URL.init(string: strURL)
        
        if let url = url {
            let request = URLRequest.init(url: url)
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                if let _  = error {
                    print(error!.localizedDescription)
                    return
                }

                if let value = data {
                    print("Data: \(value)")
                    
                    do {
                        self.arrayList = try JSONSerialization.jsonObject(with: value, options: .allowFragments) as? Array<Dictionary<String, Any>>
                        
                        
                        if let _ = self.arrayList, self.arrayList!.count > 0 {
                            DispatchQueue.main.async {
                                self.tableView.dataSource = self
                                self.tableView.delegate = self
                                self.tableView.reloadData()
                            }
                        }
                        
                        print("JSON Object: \(String(describing: self.arrayList))")
                    }
                    catch let err {
                        print("Invalid JSON: \(err.localizedDescription)")
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let arrayList = arrayList {
            return arrayList.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        if let arrayList = arrayList {
            let dict = arrayList[indexPath.row]
            
            if let dict  = dict {
                let userID = dict["userId"] as? Int
                cell.userID.text =  String(format: "%d", userID!)
                cell.title.text = dict["title"] as? String
                cell.bodyLabel.text = dict["body"] as? String
            }
        }
        
        return cell
    }
    
}

