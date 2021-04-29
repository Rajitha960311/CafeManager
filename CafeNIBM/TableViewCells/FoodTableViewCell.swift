//
//  FoodTableViewCell.swift
//  CafeNIBM
//
//  Created by Nuwan Mudalige on 2021-04-27.
//

import UIKit
import Kingfisher

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var lblFoodDiscount: UILabel!
    @IBOutlet weak var lblFoodPrice: UILabel!
    @IBOutlet weak var lblFoodDesc: UILabel!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var imgFood: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView(foodItem:FoodItem) {
        lblFoodName.text = foodItem.foodName
        lblFoodDesc.text = foodItem.foodDes
        lblFoodPrice.text = "LKR \(foodItem.foodPrice)"
//        imgFood.image = UIImage(named: foodItem.image)
        imgFood.kf.setImage(with: URL(string: foodItem.image))
        
        if foodItem.discount > 0 {
            lblFoodDiscount.isHidden = false
            lblFoodDiscount.text = "\(foodItem.discount)%"
            
        }else{
            lblFoodDiscount.isHidden = true
            lblFoodDiscount.text = ""
        }
        
    }
    
}
