//
//  WebViewController.swift
//  NewsApp
//
//  Created by Gabriel de Castro Chaves on 05/08/22.
//

import UIKit
import WebKit

final class WebViewController: UIViewController, WKNavigationDelegate {
    
    //MARK: - Vars
    var stringURL: String?
        
    //MARK: - IBOutlets
    @IBOutlet weak var wkWebView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        loadWebView()
        self.wkWebView.navigationDelegate = self
    }
        
    //MARK: - Funcs
    func loadWebView() {
        guard let url = URL(string: self.stringURL ?? "" ) else { return }
        wkWebView?.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator?.stopAnimating()
    }

}


