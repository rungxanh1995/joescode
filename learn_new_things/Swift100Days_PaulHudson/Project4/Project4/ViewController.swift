//
//  ViewController.swift
//  Project4
//
//  Created by Joe Pham on 2021-01-09.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
  // Class ViewController inherits UIViewController
  // and conforms to WKNavigationDelegate protocol
  
  // Create the web view
  var webView: WKWebView!
  // Create the progress view
  var progressView: UIProgressView!
  
  // Alter built-in loadView()
  override func loadView() {
    // 1. Assign an empty WKWebView instance to webView
    webView = WKWebView()
    
    // 2. Set webView's navigationDelegate to the current view controller
    webView.navigationDelegate = self
    // A delegate is 1 thing acting in place of another
    // This might be why the website takes the entire screen to display
    // (i.e. the navigation bar is on top of the website's floating navbar at the moment)
    
    // 3. Make the current view of loadView() that webView
    view = webView
    
    // This is the initial website displayed by this app
    let url = URL(string: "https://www.hackingwithswift.com")!
    // 1. This assigns a URL object out of String to url
    webView.load(URLRequest(url: url))
    // 2. This create a URLRequest object from the url, then feeds webView to load
    webView.allowsBackForwardNavigationGestures = true
    // 3. This enables backward/forward edge-swiping gesture
    
    // End of loadView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    // Add a navigation button to hold list of websites (as alert options) to browse
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))

    // Declare value as a UIProgressView instance to progressView
    progressView = UIProgressView(progressViewStyle: .default)
    // Set its layout size to fit its contents fully
    progressView.sizeToFit()
    // Create a progress button by passing the UIProgressView instance in there to param customView
    let progressButton = UIBarButtonItem(customView: progressView)
    // Also create a flexible space
    let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    // And a refresh button
    let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
    
    // Create an array containing the defined buttons -> sets to toolbarItems
    toolbarItems = [progressButton, spacer, refresh]
    navigationController?.isToolbarHidden = false
    
    // Add a KVO observer of the estimatedProgress property on the web view
    webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    // The 4 params meaning are:
    // 1. _ observer: who the observer is (in this case we are the observer)
    // 2. forKeyPath: what to observe (the estimatedProgress property of WKWebView inside a key path)
    // 3. options: which value we want (the value that was just set, hence the new one)
    // 4. context: arbitrary data of the value provided when the observer was registered to receive KVO notifications
    
    // End of viewDidLoad()
    }
  
  // Obj-C openTapped() method to display UIAlertController options
  // These options are pre-set websites for users to browse
  @objc func openTapped() {
    let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
    ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
    ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
    present(ac, animated: true)
    }
  
  // openPage method that takes param value from UIAlertAction above
  // Then string interpolated it in a complete URL and passed to webView to load as a URLRequest
  func openPage(action: UIAlertAction) {
    let url = URL(string: "https://" + action.title!)!
    webView.load(URLRequest(url: url))
  }
  
  // Update title of webView to title of webpage after finished loading the site
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    title = webView.title
  }
  
  // Edit observeValue() method to tell when the estimatedProgress value has changed
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    // When the keyPath equates string-converted value of estimatedProgress
    if keyPath == "estimatedProgress" {
      // Convert the estimatedProgress value of webView to a float & assign to progressView.progress
      progressView.progress = Float(webView.estimatedProgress)
    }
  }
  
  // End of Class
}

