//
//  DataModel.swift
//  MyNews
//
//  Created by Bartłomiej Lubiński on 14.07.2018.
//  Copyright © 2018 Bartłomiej Lubiński. All rights reserved.
//

import Foundation

class DataModel {
	
	var categories = [Category]()
	
	func documentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
	
	func dataFilePath() -> URL {
		return documentsDirectory().appendingPathComponent("Categories.plist")
	}
	
	func saveCategories() {
		let encoder = PropertyListEncoder()
		
		do {
			let data = try encoder.encode(categories)
			try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
		} catch {
			print("Error encoding categories array!")
		}
	}
	
	func loadCategories() {
		let path = dataFilePath()
		
		if let data = try? Data(contentsOf: path) {
			let decoder = PropertyListDecoder()
			do {
				categories = try decoder.decode([Category].self, from: data)
			} catch {
				print("Error decoding categories array!")
			}
		}
	}
	
	init() {
		loadCategories()
	}
	
}
