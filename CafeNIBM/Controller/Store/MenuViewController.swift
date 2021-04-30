//
//  MenuViewController.swift
//  CafeNIBM
//
//  Created by Nuwan Mudalige on 2021-04-30.
//

import UIKit
import Firebase
import FirebaseStorage
import Loaf

class MenuViewController: UIViewController {

    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var txtFoodCategory: UITextField!
    @IBOutlet weak var txtFoodDiscount: UITextField!
    @IBOutlet weak var txtFoodPrice: UITextField!
    @IBOutlet weak var txtFoodDescription: UITextField!
    @IBOutlet weak var txtFoodName: UITextField!
    
    let databaseReference = Database.database().reference()
    var categoryPicker = UIPickerView()
    var selectedCategoryIndex = 0
    var categoryList: [Category] = []
    
    var selectedImage: UIImage?
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.onPickImageClicked))
        self.imgFood.isUserInteractionEnabled = true
        self.imgFood.addGestureRecognizer(gesture)
        
        self.refreshCategories()
    }

    @IBAction func onAddFoodPressed(_ sender: UIButton) {
        let foodItem = Food(
            foodItemID: "",
            foodName: txtFoodName.text ?? "",
            foodDescription: txtFoodDescription.text ?? "",
            foodPrice: Double(txtFoodPrice.text ?? "") ?? 0,
            discount: Int(txtFoodDiscount.text ?? "") ?? 0,
            foodImg: "",
            foodCategory: categoryList[selectedCategoryIndex].catergoryName,
            isActive: true)
        
        self.addFoodItem(foodItem: foodItem)

    }
    
    @objc func onPickImageClicked(_ sender: UIImageView){
        self.imagePicker.present(from: sender)
    }
}

extension MenuViewController{
    
    func addFoodItem(foodItem: Food) {
        
        guard let image = self.selectedImage else {
            Loaf("Add an image", state: .error, sender: self).show()
            return
        }
        
        if let uploadData = image.jpegData(compressionQuality: 0.5) {
            
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpeg"
            
            Storage.storage().reference().child("foodItemImages").child(foodItem.foodName).putData(uploadData, metadata: metaData) {
                meta, error in
                
                if let error = error {
                    print(error.localizedDescription)
                    Loaf(error.localizedDescription, state: .error, sender: self).show()
                    return
                }
                
                Storage.storage().reference().child("foodItemImages").child(foodItem.foodName).downloadURL(completion: {
                    (url,error) in
                    guard let downloadURL = url else {
                        if let error = error {
                            print(error.localizedDescription)
                            Loaf(error.localizedDescription, state: .error, sender: self).show()
                        }
                        return
                    }
                    
                    Loaf("Image uploaded", state: .success, sender: self).show()
                    
                    let data = [
                        "food_name" : foodItem.foodName,
                        "description" : foodItem.foodDescription,
                        "price" : foodItem.foodPrice,
                        "discount" : foodItem.discount,
                        "category" : foodItem.foodCategory,
                        "isActive" : foodItem.isActive,
                        "imgage" : downloadURL.absoluteString
                    ] as [String : Any]
                    
                    self.databaseReference
                        .child("foodItems")
                        .childByAutoId()
                        .setValue(data) {
                            error, ref in
                            if let error = error {
                                Loaf(error.localizedDescription, state: .error, sender: self).show()
                            } else {
                                Loaf("Food item added !", state: .success, sender: self).show()
                            }
                        }
                    
                })
            }
        }
        
    }
    func refreshCategories() {
        self.categoryList.removeAll()
        databaseReference
            .child("categories")
            .observeSingleEvent(of: .value, with: {
                snapshot in
                if snapshot.hasChildren() {
                    guard let data = snapshot.value as? [String: Any] else {
                        return
                    }
                    
                    for category in data {
                        if let categoryInfo = category.value as? [String: String] {
                            self.categoryList.append(Category(categoryID: category.key, catergoryName: categoryInfo["name"]!))
                        }
                    }
                    self.setupCategoryPicker()
                }
            })
    }
}

extension MenuViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func setupCategoryPicker() {
        let pickerToolBar = UIToolbar()
        pickerToolBar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(onPickerCancelled))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        pickerToolBar.setItems([space, cancelButton], animated: true)
        
        txtFoodCategory.inputAccessoryView = pickerToolBar
        txtFoodCategory.inputView = categoryPicker
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
    }
    
    @objc func onPickerCancelled() {
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryList[row].catergoryName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtFoodCategory.text = categoryList[row].catergoryName
        selectedCategoryIndex = row
    }
}

extension MenuViewController: ImagePickerDelegate{
    func didSelect(image: UIImage?)  {
        self.imgFood.image = image
        self.selectedImage = image
    }
}
