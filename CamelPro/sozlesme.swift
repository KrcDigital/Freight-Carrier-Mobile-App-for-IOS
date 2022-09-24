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
        let myURL = URL(string:"https://firebasestorage.googleapis.com/v0/b/camelpro-6cbbc.appspot.com/o/sozlesme.pdf?alt=media&token=6b493d19-2be0-46e0-880b-440c4dddc244")
               let myRequest = URLRequest(url: myURL!)
               webView.load(myRequest)
        // Do any additional setup after loading the view.
    }
    

    
}
