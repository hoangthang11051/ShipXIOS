//
//  MainTabBar.swift
//  DogApp
//
//  Created by Admin on 10/22/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {
    var order:Order?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hoangthang",order?.hero_id)
        guard let viewControllers = viewControllers else{
            return
        }
        for viewController in viewControllers{
            if let profileNavigation = viewController as? ChitietNavi{
                if let profileVc = profileNavigation.viewControllers.first as? TestViewController{
                    profileVc.order = order
                }
            }
        }
    }
}
