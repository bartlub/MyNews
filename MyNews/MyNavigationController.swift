//
//  MyNavigationController.swift
//  MyNews
//
//  Created by Bartłomiej Lubiński on 10.08.2018.
//  Copyright © 2018 Bartłomiej Lubiński. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController {
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	override var childViewControllerForStatusBarStyle: UIViewController? {
		return nil
	}
	
}
