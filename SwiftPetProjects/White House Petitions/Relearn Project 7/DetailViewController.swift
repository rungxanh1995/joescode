//
//  DetailViewController.swift
//  Relearn Project 7
//
//  Created by Joe Pham on 2021-03-06.
//

import UIKit

class DetailViewController: UIViewController {
	// MARK: - Text placeholders
	@IBOutlet var petitionTitle: UITextView!
	@IBOutlet var petitionBody: UITextView!
	
	var detailItem: Petition?
	
	var bodyText = String()
	
	// MARK: - viewDidLoad()
	override func viewDidLoad() {
        super.viewDidLoad()

		title = "Petition Details"
		navigationItem.largeTitleDisplayMode = .never

		guard detailItem != nil else { return }
		
		bodyText = detailItem?.body ?? "No petition content"
		bodyText += "\n\n• Link: \(detailItem?.url ?? "No URL provided")"	// petition url
		bodyText += "\n\n• ID: \(detailItem?.id ?? "No ID provided")"	// petition id
		bodyText += "\n\n• Signature threshold required for this petition was \(String(detailItem?.signatureThreshold ?? 0)), "	// signature threshold
		bodyText += "and actual signature count collected was \(String(detailItem?.signatureCount ?? 0))"	// signature count
		
		
		petitionTitle.text = detailItem?.title
		petitionBody.text = bodyText
    }
    



}
