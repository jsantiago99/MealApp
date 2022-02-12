//
//  MealManager.swift
//  MealApp
//
//  Created by John Santiago on 2/12/22.
//

import Foundation

protocol CategoryManagerDelegate {
    func didFailWithError(error: Error)
    func didUpdateCategory(_ categoryManager: CategoryManager, category: CategoryModel)
}
struct CategoryManager {
    let baseURL = "www.themealdb.com/api/json/v1/1/categories.php"
    let currencyArray: [String] = []
    var delegate: CategoryManagerDelegate?
    
    func fetchCategories() {
        let urlString = "\(baseURL)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
        
            let session = URLSession(configuration: .default)
        
            let task = session.dataTask(with: url) {data, response, error in
                if (error != nil) {
                    self.delegate?.didFailWithError(error: error!)
                } else {
                    if let safeData = data {
                        if let category = self.parseJSON(safeData) {
                            self.delegate?.didUpdateCategory(self, category: category)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> CategoryModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CategoryData.self, from: data)
            let array = decodedData.categoryArray
            var categoryModel = CategoryModel()
            
          
            for item in array {
                let id = item.idCategory
                let str = item.strCategory
                let thumb = item.thumbCategory
                let description = item.descriptionCategory
                
                let categoryFeatures = CategoryModelFeatures(categoryId: id, categoryStr: str, categoryThumbnail: thumb, categoryDescription: description)
                
                categoryModel.categoryModelArray.append(categoryFeatures)
            }
            
            return categoryModel
            
            
            
        }
        catch {
            print(error)
            return nil
        }
        
        
    }
    
    
}
