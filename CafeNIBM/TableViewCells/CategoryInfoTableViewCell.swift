//
//  CategoryInfoTableViewCell.swift
//  CafeNIBM
//
//  Created by Nuwan Mudalige on 2021-04-30.
//

import UIKit

class CategoryInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCatNaame: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class var reuseIndentifier: String {
        return "CategoryInfoReusable"
    }
    class var nibName: String {
        return "CategoryInfoTableViewCell"
    }
    
    func configXIB(category: Category) {
        lblCatNaame.text = category.catergoryName
    }
    
}
