//
//  CategoryCollectionViewCell.swift
//  CafeNIBM
//
//  Created by Nuwan Mudalige on 2021-04-30.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var lblCategoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class var reuseIdentifier: String {
        return "CategoryCollectionCellReusable"
    }
    
    class var nibName: String {
        return "CategoryCollectionViewCell"
    }
    
    func configXIB(category: Category) {
        lblCategoryName.text = category.catergoryName
    }

}
