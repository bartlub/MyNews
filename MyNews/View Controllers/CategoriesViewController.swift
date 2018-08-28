//
//  CategoriesViewController.swift
//  MyNews
//
//  Created by Bartłomiej Lubiński on 12.07.2018.
//  Copyright © 2018 Bartłomiej Lubiński. All rights reserved.
//

import UIKit

class CategoriesViewController: UITableViewController, CategoryDetailViewControllerDelegate {
	
	var dataModel: DataModel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	// MARK: - Table View Delegate Methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataModel.categories.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
		
		let name = dataModel.categories[indexPath.row].name
		cell.textLabel?.text = name
		
		let iconName = dataModel.categories[indexPath.row].iconName
		cell.imageView?.image = UIImage(named: iconName)
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		dataModel.categories.remove(at: indexPath.row)
		
		let indexPaths = [indexPath]
		tableView.deleteRows(at: indexPaths, with: .automatic)
	}
	
	// MARK: - Category Detail Delegate Methods
	
	func addCategory(_ category: Category) {
		dataModel.categories.append(category)
		tableView.reloadData()
	}
	
	func editCategory(_ category: Category) {
		tableView.reloadData()
		
		/* or do it more precisely
		if let index = dataModel.categories.index(of: category) {
			let indexPath = IndexPath(row: index, section: 0)
			if let cell = tableView.cellForRow(at: indexPath) {
				cell.textLabel?.text = category.name
				cell.imageView?.image = UIImage(named: category.iconName)
			}
		} */
	}
	
	// MARK: - Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "AddCategory" {
			let controller = segue.destination as! CategoryDetailViewController
			controller.delegate = self
		} else if segue.identifier == "EditCategory" {
			let controller = segue.destination as! CategoryDetailViewController
			controller.delegate = self
			
			if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
				controller.categoryToEdit = dataModel.categories[indexPath.row]
			}
		} else if segue.identifier == "ShowCategory" {
			let controller = segue.destination as! WebsitesViewController
			
			if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
				controller.category = dataModel.categories[indexPath.row]
			}
		}
	}

}
