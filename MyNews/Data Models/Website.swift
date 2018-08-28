//
//  Website.swift
//  MyNews
//
//  Created by Bartłomiej Lubiński on 14.07.2018.
//  Copyright © 2018 Bartłomiej Lubiński. All rights reserved.
//

import Foundation

class Website: NSObject, Codable {
	
	var domainName = ""
	var customName = ""
	
	init(domainName: String, customName: String) {
		self.domainName = domainName
		self.customName = customName
		super.init()
	}
	
}
