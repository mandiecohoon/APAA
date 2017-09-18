//
//  RegistrationViewController.swift
//  AlumniAppSwift
//
//  Created by Amanda Cohoon on 2015-07-22.
//  Copyright (c) 2015 Amanda Cohoon. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class RegistrationViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    // Connect controller to web view
    @IBOutlet var containerView : UIView! = nil
    
    // Make web view into WebKit web view
    var webView: WKWebView?
    
    // Javascript to inject into the page once its loaded
    let source = "document.getElementsByTagName('header')[0].style.display = 'none'; document.getElementsByTagName('footer')[0].style.display = 'none'; var leftsideBar = document.getElementById('leftside-bar'); if (leftsideBar != null) leftsideBar.style.display = 'none'; var wrapper = document.getElementById('wrapper'); if (wrapper != null) wrapper.style.display = 'none'; var content = document.getElementById('main-content'); var topLevel = content.parentNode.parentNode.parentNode; content = topLevel.parentNode.insertBefore(content, topLevel); topLevel.style.display = 'none';var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width, initial-scale=0.68, maximum-scale=1.0, user-scalable=no'); document.getElementsByTagName('head')[0].appendChild(meta);document.getElementsByTagName('body')[0].style.background = 'white';" // Added view port scale to accomindate padding on the form that overlaps input fields

    
    // Load view
    override func loadView() {
        super.loadView()
        
        // Injecting javascript to the end of the document while view loads
        var contentController = WKUserContentController();
        var userScript = WKUserScript(
            source: source,
            injectionTime: WKUserScriptInjectionTime.AtDocumentEnd,
            forMainFrameOnly: true
        )
        contentController.addUserScript(userScript)
        
        var config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        self.webView = WKWebView(
            frame: CGRectMake(0, 0, (self.containerView.bounds.width) - 100, (self.containerView.bounds.height) - 50), //self.containerView.bounds
            configuration: config
        )
        self.view = self.webView!
        
        self.webView!.navigationDelegate = self
        self.webView!.UIDelegate = self
        
        /* end of js webkit webview inject */
        
        // Disables user from unnessecary verticle & horizontal scrolling
        webView!.scrollView.bounces = false;
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Loading the web page to the view
        var url = NSURL(string:"http://www.lambtoncollege.ca/About_Us/Alumni_Association/Registration/")
        var req = NSURLRequest(URL:url!)
        self.webView!.loadRequest(req)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Error catch for webview
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // Links clicked inside webview are opened in Safari
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: ((WKNavigationActionPolicy) -> Void)) {
        if (navigationAction.navigationType == WKNavigationType.LinkActivated && !navigationAction.request.URL!.host!.lowercaseString.hasPrefix("lambtoncollege.ca")) {
            UIApplication.sharedApplication().openURL(navigationAction.request.URL!)
            decisionHandler(WKNavigationActionPolicy.Cancel) //links open in safari
        } else {
            decisionHandler(WKNavigationActionPolicy.Allow) //links open in view
        }
    }
    
    // Shows activity indicator in the status bar
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    // Stops activity indicator when actvity is finished
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
}
