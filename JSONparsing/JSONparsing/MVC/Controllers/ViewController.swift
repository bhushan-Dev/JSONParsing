//
//  ViewController.swift
//  JSONParsing
//
//  Created by Bhushan Udawant on 15/09/18.
//  Copyright © 2018 Bhushan Udawant. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    private let strURL = "https://jsonplaceholder.typicode.com/posts"
    var arrayList: Array<Dictionary<String, Any?>?>?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        
        
        // Call after delay
        //activityIndicator.startAnimating()
        //self.perform(#selector(callPostApi), with: nil, afterDelay: 10)

        callPostApi()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    private func callPostApi() {
        let url = URL.init(string: strURL)
        
        guard let _ = url else {
            return
        }
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        if let url = url {
            let request = URLRequest.init(url: url)
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
                
                if let _  = error {
                    print(error!.localizedDescription)
                    let message = error!.localizedDescription
                    
                    DispatchQueue.main.async {
                        self.networkAlert(with: message)
                    }
                    
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
    
    // Mark: DataSource
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
    
    
    // Mark: Delegate
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        
        if let arrayList = arrayList {
            let dict = self.arrayList?[indexPath.row]
            if let dict = dict {
                detailsVC.dict = dict
            }
        }
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    // MARK: Alert
    
    private func alert(with message: String) {
        let alert = UIAlertController.init(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okButton = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default) { (_) in
            print("Button Clicked")
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func networkAlert(with message: String) {
        let alert = UIAlertController.init(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let cancelButton = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel) { (_) in
            print("cancel Clicked")
        }
        let retryButton = UIAlertAction.init(title: "Retry", style: UIAlertActionStyle.destructive) { (_) in
            print("Retry Clicked")
            self.callPostApi()
        }
        alert.addAction(cancelButton)
        alert.addAction(retryButton)
        self.present(alert, animated: true, completion: nil)
    }
}

