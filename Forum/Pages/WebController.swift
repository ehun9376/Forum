//
//  WebController.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/22.
//

import Foundation

import UIKit
import WebKit
class WebViewController: UIViewController {
    
    
    var mWebView: WKWebView? = nil
    
    var url: String?
    
    convenience init(
        url: String?,
        title: String?
    ) {
        self.init()
        self.url = url
        self.title = title
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.forwordButton()
        self.backButton()
        self.loadURL(urlString: self.url ?? "")
    }
    
    private func loadURL(urlString: String) {
        let url = URL(string: urlString)
        if let url = url {
            let request = URLRequest(url: url)
            // init and load request in webview.
            mWebView = WKWebView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 70))
            if let mWebView = mWebView {
                mWebView.navigationDelegate = self
                mWebView.load(request)
                self.view.addSubview(mWebView)
                self.view.sendSubviewToBack(mWebView)
            }
        }
    }
    
    func forwordButton() {
        let button = UIButton()
        button.setTitle("下一頁", for: .normal)
        button.setTitleColor(.black, for: .normal)
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height

        button.frame = CGRectMake(self.view.frame.width-75, self.view.frame.height-70, 56, 56) // (X, Y, Height, Width)
        button.addTarget(self, action: #selector(forword), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func forword() {
        self.mWebView?.goForward()
    }
    
    

    func backButton() {
        let button = UIButton()
        button.setTitle("上一頁", for: .normal)
        button.setTitleColor(.black, for: .normal)
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height

        button.frame = CGRectMake(5, self.view.frame.height-70, 56, 56) // (X, Y, Height, Width)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func back() {
        self.mWebView?.goBack()
    }
 
}


extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
    }
}
