//
//  WebPageViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 20/11/23.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    let url: String
    
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(url: "https://apple.com")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: url)!
        webView.load(URLRequest(url: url))
    }
}
