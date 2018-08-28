//
//  IconPickerViewController.swift
//  MyNews
//
//  Created by Bartłomiej Lubiński on 18.07.2018.
//  Copyright © 2018 Bartłomiej Lubiński. All rights reserved.
//

import UIKit

protocol IconPickerViewControllerDelegate: class {
	func pickIcon(_ iconName: String)
}

class IconPickerViewController: UITableViewController {
	
	let icons = ["No Icon", "Apple", "Atom", "Ball", "Book", "Camera", "Car", "Clapperboard", "Earth", "Folder", "Gamepad", "Government", "Heart", "Money", "Music", "Newspaper", "Plate", "Programming", "Running", "Smartphone", "Sun", "T-shirt"]
	var iconName = ""
	weak var delegate: IconPickerViewControllerDelegate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	// MARK: - Table View Delegate Methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return icons.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)
		
		let iconName = icons[indexPath.row]
		cell.textLabel?.text = iconName
		cell.imageView?.image = UIImage(named: iconName)
		
		if self.iconName == iconName {
			cell.accessoryType = .checkmark
		} else {
			cell.accessoryType = .none
		}
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let iconName = icons[indexPath.row]
		delegate?.pickIcon(iconName)
		navigationController?.popViewController(animated: true)
	}
	
}
