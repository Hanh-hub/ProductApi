//
//  AddProductViewController.swift
//  Login
//
//  Created by Hanh Vo on 7/5/23.
//

import UIKit

class AddProductViewController: UIViewController {
    
    var viewModel = AddProductViewModel()
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBAction func submitButton(_ sender: Any) {
        self.addProduct{success in
            if success {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                    self.statusLabel.text = "Product added successfully! Do you want to add another product?"
                    
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Do any additional setup after loading the view.
    }
    
    func addProduct(onComplete: @escaping(Bool)-> Void){
        let product = Product(id: 101, title: titleTextField.text, description: "awesome", price: 102, discountPercentage: nil, rating: nil, stock: nil, brand: nil, category: nil, thumbnail: nil, images: nil)
        viewModel.addProduct(product: product) { apiError in
            if let error = apiError {
                self.presentAlert(message: error.localizedDescription)
            }
            onComplete(true)
            
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
