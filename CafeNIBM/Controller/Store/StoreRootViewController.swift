//
//  StoreRootViewController.swift
//  CafeNIBM
//
//  Created by Nuwan Mudalige on 2021-04-30.
//

import UIKit

class StoreRootViewController: UIViewController {

    var tabBarContainer: UITabBarController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tabBarSegue"{
            self.tabBarContainer = segue.destination as? UITabBarController
        }
        
        self.tabBarContainer?.tabBar.isHidden = true
    }
    
    @IBAction func onSegIndexChanged(_ sender: UISegmentedControl) {
        
        tabBarContainer?.selectedIndex = sender.selectedSegmentIndex
    }
    
    
}
