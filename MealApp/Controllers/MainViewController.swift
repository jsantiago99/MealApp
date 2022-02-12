//
//  ViewController.swift
//  MealApp
//
//  Created by John Santiago on 2/11/22.
//

import UIKit

class MainViewController: UIViewController, UIPickerViewDataSource {
    
    var categoryModel = CategoryModel()
    var categoryManager = CategoryManager()
    
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryManager.delegate = self
        categoryManager.fetchCategories()
        self.categoryPicker.dataSource = self
        self.categoryPicker.delegate = self
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryManager.currentArray.count
    }
    

    
    


}

extension MainViewController : CategoryManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateCategory(_ categoryManager: CategoryManager, category: CategoryModel) {
        DispatchQueue.main.async {
            
            for item in category.categoryModelArray {
                let nameCategory = item.categoryStr
                print(nameCategory)
                self.categoryManager.add(strName: nameCategory!)
            }
            print("Success")
            self.categoryPicker.reloadAllComponents()
            
        }
        
    }
}

extension MainViewController : UIPickerViewDelegate {
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("Populated rows")
        return categoryManager.currentArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(categoryManager.currentArray[row])
    }
}

