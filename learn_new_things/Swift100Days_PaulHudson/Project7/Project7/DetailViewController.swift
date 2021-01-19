//
//  DetailViewController.swift
//  Project7
//
//  Created by Joe Pham on 2021-01-19.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }
        // Title of the view
        title = "Petition Details"
        // Disable large title in Detail screen
        navigationItem.largeTitleDisplayMode = .never
        
        // Custom HTML code to be rendered by webView
        let html = """
        <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <style>
                    body {
                    font-size: 1.1em;
                    font-family: Arial, Helvetica, sans-serif;
                    background: transparent;
                    }
                    h1 {
                    font-size: 1.5em;
                    font-family: Georgia, sans-serif;
                    }
                </style>
            </head>
            <body>
                <h1>\(detailItem.title)</h1>
                <br>
                <p>\(detailItem.body)</p>
            </body>
        </html>
        """
        // Ask webView to load the custom HTML code
        webView.loadHTMLString(html, baseURL: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
