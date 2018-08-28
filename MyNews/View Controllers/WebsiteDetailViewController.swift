//
//  WebsiteDetailViewController.swift
//  MyNews
//
//  Created by Bartłomiej Lubiński on 20.07.2018.
//  Copyright © 2018 Bartłomiej Lubiński. All rights reserved.
//

import UIKit

protocol WebsiteDetailViewControllerDelegate: class {
	func addWebsite(_ website: Website)
	func editWebsite(_ website: Website)
}

class WebsiteDetailViewController: UITableViewController, UITextFieldDelegate {
	
	@IBOutlet weak var domainNameTextField: UITextField!
	@IBOutlet weak var customNameTextField: UITextField!
	@IBOutlet weak var doneBarButton: UIBarButtonItem!
	
	var websiteToEdit: Website?
	weak var delegate: WebsiteDetailViewControllerDelegate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		domainNameTextField.becomeFirstResponder()
		domainNameTextField.attributedPlaceholder = NSAttributedString(string: "e.g. apple.com", attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.2)])
		customNameTextField.attributedPlaceholder = NSAttributedString(string: "e.g. Apple", attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.2)])
		
		if let website = websiteToEdit {
			title = "Edit Website"
			doneBarButton.isEnabled = true
			domainNameTextField.text = website.domainName
			customNameTextField.text = website.customName
		}
		
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
		gestureRecognizer.cancelsTouchesInView = false
		tableView.addGestureRecognizer(gestureRecognizer)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	@objc func hideKeyboard(_ gestureRecognizer: UIGestureRecognizer) {
		let point = gestureRecognizer.location(in: tableView)
		let indexPath = tableView.indexPathForRow(at: point)
		
		if indexPath == nil || !(indexPath!.section == 0 && indexPath!.row == 0) {
			domainNameTextField.resignFirstResponder()
		}
		
		if indexPath == nil || !(indexPath!.section == 1 && indexPath!.row == 0) {
			customNameTextField.resignFirstResponder()
		}
	}
	
	// MARK: - Table View Delegate Methods
	
	override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
		return nil
	}
	
	// MARK: - Text Field Delegate Methods
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let oldText = domainNameTextField.text!
		let stringRange = Range(range, in: oldText)!
		let newText = oldText.replacingCharacters(in: stringRange, with: string)

		doneBarButton.isEnabled = !newText.isEmpty
		return true
	}
	
	// MARK: - IB Action Methods
	
	@IBAction func done() {
		if let website = websiteToEdit {
			website.domainName = domainNameTextField.text!
			website.customName = customNameTextField.text!
			delegate?.editWebsite(website)
		} else {
			let website = Website(domainName: domainNameTextField.text!, customName: customNameTextField.text!)
			delegate?.addWebsite(website)
		}
		
		navigationController?.popViewController(animated: true)
	}
	
	@IBAction func cancel() {
		navigationController?.popViewController(animated: true)
	}
	
}
