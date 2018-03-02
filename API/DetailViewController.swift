//
//  DetailViewController.swift
//  API
//
//  Created by 藤田佳恵 on 2018/01/19.
//  Copyright © 2018年 藤田佳恵. All rights reserved.
//

//ListViewControllerからのリンク

import UIKit

class DetailViewController: UIViewController {
    var link : String!
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string:self.link){
            let request = URLRequest(url:url)
            self.webView.loadRequest(request)
            
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
