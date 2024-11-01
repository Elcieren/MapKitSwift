//
//  WebViewController.swift
//  Project16
//
//  Created by Eren Elçi on 1.11.2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var url: URL?
    @IBOutlet var webView: WKWebView!
    
    override func loadView() {
           webView = WKWebView()
           view = webView
       }
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = url {
                    webView.load(URLRequest(url: url))
                }
    }
    

    

}
