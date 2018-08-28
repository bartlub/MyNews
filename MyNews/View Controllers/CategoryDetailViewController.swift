//
//  CategoryDetailViewController.swift
//  MyNews
//
//  Created by Bartłomiej Lubiński on 14.07.2018.
//  Copyright © 2018 Bartłomiej Lubiński. All rights reserved.
//

import UIKit

protocol CategoryDetailViewControllerDelegate: class {
	func addCategory(_ category: Category)
	func editCategory(_ category: Category)
}

class CategoryDetailViewController: UITableViewController, UITextFieldDelegate, IconPickerViewControllerDelegate {
	
	@IBOutlet weak var categoryNameTextField: UITextField!
	@IBOutlet weak var iconNameLabel: UILabel!
	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var doneBarButton: UIBarButtonItem!
	
	var categoryToEdit: Category?
	var iconName = "No Icon"
	weak var delegate: CategoryDetailViewControllerDelegate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		categoryNameTextField.becomeFirstResponder()
		categoryNameTextField.attributedPlaceholder = NSAttributedString(string: "e.g. Technology", attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.2)])
		
		if let category = categoryToEdit {
			title = "Edit Category"
			doneBarButton.isEnabled = true
			categoryNameTextField.text = category.name
			iconName = category.iconName
		}
		
		iconNameLabel.text = iconName
		iconImageView.image = UIImage(named: iconName)
		
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
		
		if indexPath != nil && indexPath!.section == 0 && indexPath!.row == 0 {
			return
		}
		
		categoryNameTextField.resignFirstResponder()
	}
	
	// MARK: - Table View Delegate Methods
	
	override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
		if indexPath.section == 1 {
			return indexPath
		} else {
			return nil
		}
	}
	
	// MARK: - Text Field Delegate Methods
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let oldText = categoryNameTextField.text!
		let stringRange = Range(range, in: oldText)!
		let newText = oldText.replacingCharacters(in: stringRange, with: string)
		
		doneBarButton.isEnabled = !newText.isEmpty
		return true
	}
	
	// MARK: - Icon Picker Delegate Methods
	
	func pickIcon(_ iconName: String) {
		self.iconName = iconName
		iconNameLabel.text = iconName
		iconImageView.image = UIImage(named: iconName)
	}
	
	// MARK: - Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "PickIcon" {
			let controller = segue.destination as! IconPickerViewController
			controller.delegate = self
			controller.iconName = iconName
		}
	}
	
	// MARK: - IB Action Methods
	
	@IBAction func done() {
		if let category = categoryToEdit {
			category.name = categoryNameTextField.text!
			category.iconName = iconName
			delegate?.editCategory(category)
		} else {
			let category = Category(name: categoryNameTextField.text!, iconName: iconName)
			delegate?.addCategory(category)
		}
		
		navigationController?.popViewController(animated: true)
	}
	
	@IBAction func cancel() {
		navigationController?.popViewController(animated: true)
	}
	
}
