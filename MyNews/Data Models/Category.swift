//
//  Category.swift
//  MyNews
//
//  Created by Bartłomiej Lubiński on 14.07.2018.
//  Copyright © 2018 Bartłomiej Lubiński. All rights reserved.
//

import Foundation

class Category: NSObject, Codable {
	
	var name = ""
	var iconName = ""
	var websites = [Website]()
	
	init(name: String, iconName: String) {
		self.name = name
		self.iconName = iconName
		super.init()
	}
	
}
