//
//  WebsiteViewController.swift
//  MyNews
//
//  Created by Bartłomiej Lubiński on 23.07.2018.
//  Copyright © 2018 Bartłomiej Lubiński. All rights reserved.
//

import UIKit
import WebKit

class WebsiteViewController: UIViewController, WKNavigationDelegate {
	
	@IBOutlet weak var webView: WKWebView!
	@IBOutlet weak var refreshBarButton: UIBarButtonItem!
	@IBOutlet weak var backBarButton: UIBarButtonItem!
	@IBOutlet weak var forwardBarButton: UIBarButtonItem!
	@IBOutlet weak var progressView: UIProgressView!
	
	var website: Website!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		webView.navigationDelegate = self
		
		let domainName = website.domainName
		let customName = website.customName
		
		if customName != "" {
			title = customName
		} else {
			title = domainName
		}
		
		let url = URL(string: "http://" + domainName)
		var urlRequest = URLRequest(url: url!)
		urlRequest.timeoutInterval = 30
		webView.load(urlRequest)
		
		webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == "estimatedProgress" {
			progressView.progress = Float(webView.estimatedProgress)
		}
	}
	
	deinit {
		webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
	}
	
	// MARK: - WK Navigation Delegate Methods
	
	func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
		let url = navigationAction.request.url

		if let host = url?.host {
			if host.contains(website.domainName) {
				decisionHandler(WKNavigationActionPolicy.allow)
				return
			}
		}

		decisionHandler(WKNavigationActionPolicy.cancel)
	}
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		refreshBarButton.isEnabled = true
		backBarButton.isEnabled = webView.canGoBack
		forwardBarButton.isEnabled = webView.canGoForward
	}
	
	func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
		let alertController = UIAlertController(title: "Loading Error", message: "There has been an error while loading the page. Please check if your internet connection is active, or whether the domain name that you provided is correct.", preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
			self.navigationController?.popViewController(animated: true)
		}))
		present(alertController, animated: true)
	}
	
	// MARK: - IB Action Methods
	
	@IBAction func reloadPage() {
		webView.reload()
		refreshBarButton.isEnabled = false
	}
	
	@IBAction func goBack() {
		if webView.canGoBack {
			webView.goBack()
		}
	}
	
	@IBAction func goForward() {
		if webView.canGoForward {
			webView.goForward()
		}
	}
	
}
