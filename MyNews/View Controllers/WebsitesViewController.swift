//
//  WebsitesViewController.swift
//  MyNews
//
//  Created by Bartłomiej Lubiński on 20.07.2018.
//  Copyright © 2018 Bartłomiej Lubiński. All rights reserved.
//

import UIKit

class WebsitesViewController: UITableViewController, WebsiteDetailViewControllerDelegate {
	
	var category: Category!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = category.name
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	// MARK: - Table View Delegate Methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return category.websites.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "WebsiteCell", for: indexPath)
		
		let customName = category.websites[indexPath.row].customName
		
		if customName != "" {
			cell.textLabel?.text = customName
		} else {
			let domainName = category.websites[indexPath.row].domainName
			cell.textLabel?.text = domainName
		}
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		category.websites.remove(at: indexPath.row)
		
		let indexPaths = [indexPath]
		tableView.deleteRows(at: indexPaths, with: .automatic)
	}
	
	// MARK: - Website Detail Delegate Methods
	
	func addWebsite(_ website: Website) {
		category.websites.append(website)
		tableView.reloadData()
	}
	
	func editWebsite(_ website: Website) {
		tableView.reloadData()
	}
	
	// MARK: - Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "AddWebsite" {
			let controller = segue.destination as! WebsiteDetailViewController
			controller.delegate = self
		} else if segue.identifier == "EditWebsite" {
			let controller = segue.destination as! WebsiteDetailViewController
			controller.delegate = self
			
			if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
				controller.websiteToEdit = category.websites[indexPath.row]
			}
		} else if segue.identifier == "ShowWebsite" {
			let controller = segue.destination as! WebsiteViewController
			
			if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
				controller.website = category.websites[indexPath.row]
			}
		}
	}
	
}
