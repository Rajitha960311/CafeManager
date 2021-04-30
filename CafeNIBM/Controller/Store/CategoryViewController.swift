//
//  CategoryViewController.swift
//  CafeNIBM
//
//  Created by Nuwan Mudalige on 2021-04-30.
//

import UIKit
import FirebaseDatabase
import Loaf

class CategoryViewController: UIViewController {

    let dbReference = Database.database().reference()
    
    var categoryList:[Category] = []
    
    @IBOutlet weak var tblCategory: UITableView!
    @IBOutlet weak var txtCategoryName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblCategory.register(UINib(nibName: CategoryInfoTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: CategoryInfoTableViewCell.reuseIndentifier)
        refreshCategories()

        // Do any additional setup after loading the view.
    }

    @IBAction func onAddCatPressed(_ sender: UIButton) {
        
        if let name = txtCategoryName.text{
            addCategory(name: name)
        }else{
            Loaf("Enter a category name", state: .error, sender: self).show()
        }
        
    }
    
}

extension CategoryViewController {
    
    func addCategory(name:String)  {
        dbReference
            .child("categories")
            .childByAutoId()
            .child("name")
            .setValue(name){
                error, ref in
                if let error = error{
                    Loaf(error.localizedDescription, state: .error, sender: self).show()
                }else{
                    Loaf("Category Created !", state: .success, sender: self).show()
                    self.refreshCategories()
                }
            }
        
    }
    
    func refreshCategories() {
        self.categoryList.removeAll()
        dbReference.child("categories").observeSingleEvent(of: .value, with: {
            snapshot in
            if snapshot.hasChildren(){
                guard let data = snapshot.value as? [String: Any] else {
                    return
                }
                
                for category in data{
                    if let catInfo = category.value as? [String: String]{
                        self.categoryList.append(Category(categoryID: category.key, catergoryName: catInfo["name"]!))
                    }
                }
                
                self.tblCategory.reloadData()
//                print(self.categoryList)
            }
        })
    }
    
    func removeCategory(category: Category) {
        dbReference
            .child("categories")
            .child(category.categoryID)
            .removeValue(){
                error, dbReference in
                if error != nil{
                    Loaf("Could not remove category !", state: .error, sender: self).show()
                }else{
                    Loaf("Category Removed !", state: .success, sender: self).show()
                    self.refreshCategories()
                }
            }
    }
    
}

extension CategoryViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tblCategory.dequeueReusableCell(withIdentifier: CategoryInfoTableViewCell.reuseIndentifier,for:indexPath) as! CategoryInfoTableViewCell
        cell.selectionStyle = .none
        cell.configXIB(category: self.categoryList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.removeCategory(category: categoryList[indexPath.row])
            refreshCategories()
        }
    }
}


    

