//
//  FoodItemTableViewCell.swift
//  CafeNIBM
//
//  Created by Nuwan Mudalige on 2021-04-30.
//

import UIKit
import Kingfisher

class FoodItemTableViewCell: UITableViewCell {

    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblFoodPrice: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    
    @IBOutlet weak var switchFoodStatus: UISwitch!
    
    var delegate: FoodItemCellActions?
    var foodItem: Food?
    
    var rowIndex = 0
    
    class var reuseIdentifier: String {
        return "FoodItemCellReusable"
    }
    
    class var nibName: String {
        return "FoodItemTableViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configXIB(foodItem: Food, index: Int) {
        lblFoodName.text = foodItem.foodName
        lblDescription.text = foodItem.foodDescription
        lblFoodPrice.text = "LKR \(foodItem.foodPrice)"
        imgFood.kf.setImage(with: URL(string: foodItem.foodImg))
        if foodItem.discount > 0 {
            lblDiscount.isHidden = false
            lblDiscount.text = "\(foodItem.discount)%"
            
        }else{
            lblDiscount.isHidden = true
            lblDiscount.text = ""
        }
        
        switchFoodStatus.isOn = foodItem.isActive
        
        self.rowIndex = index
        self.foodItem = foodItem
    }
    

    
    @IBAction func onFoodStatusChanged(_ sender: UISwitch) {
        self.delegate?.onFoodItemStatusChanged(foodItem: self.foodItem!, status: sender.isOn)
    }
}
protocol FoodItemCellActions {
    func onFoodItemStatusChanged(foodItem: Food, status: Bool)
}
