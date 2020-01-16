//
//  UserDetailVC.swift
//  Github Users
//
//  Created by Razan Nasir on 16/01/20.
//  Copyright © 2020 Razan Nasir. All rights reserved.
//

import UIKit
import WebKit

class UserDetailVC: UIViewController {
    
    var webUrl : String?
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let link = URL(string:webUrl ?? "")!
        let request = URLRequest(url: link)
        webView.load(request)
    }

}
