//
//  FoodViewController.swift
//  CafeNIBM
//
//  Created by Nuwan Mudalige on 2021-04-27.
//

import UIKit
import Firebase


class FoodViewController: UIViewController {

    @IBOutlet weak var tblFood: UITableView!
    
    var ref: DatabaseReference!
    
    var foodItems: [FoodItem]=[
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblFood.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "foodCellReuseIdentifier")
        
        ref = Database.database().reference()
        getFoodItemData()
    }

}

extension FoodViewController{
    func getFoodItemData() {
        ref.child("foodItems").observe(.value, with: {
            (snapshot) in
            
            if let data = snapshot.value {
                if let foodItems = data as? [String: Any]{
                    for item in foodItems {
                        if let foodInfo = item.value as? [String: Any]{
                            print(foodInfo)
                        }
                    }
                }
            }
        })
    }
}

extension FoodViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tblFood.dequeueReusableCell(withIdentifier: "foodCellReuseIdentifier",for:indexPath) as! FoodTableViewCell
        cell.setupView(foodItem: foodItems[indexPath.row])
        return cell
    }
    
    
    
}
