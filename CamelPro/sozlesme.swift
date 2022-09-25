//
//  sozlesme.swift
//  CamelPro
//
//  Created by Can Kirac on 26.05.2022.
//

import UIKit
import WebKit




class sozlesme: UIViewController , WKUIDelegate{

    var webView: WKWebView!
    override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            view = webView
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string:"")
               let myRequest = URLRequest(url: myURL!)
               webView.load(myRequest)
        // Do any additional setup after loading the view.
    }
    

    
}
