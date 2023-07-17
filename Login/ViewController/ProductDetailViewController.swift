//
//  ProductDetailViewController.swift
//  Login
//
//  Created by Hanh Vo on 6/27/23.
//

import UIKit

class ProductDetailViewController: UIViewController {
   var viewModel: ProductDetailViewModel!
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var soldByLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configure(product: viewModel.product)
        viewModel.setUpSubscriber { [weak self] product in
            DispatchQueue.main.async {
                self?.configure(product: product)
            }
        }
    }
    
    func configure(product: Product?){
        if let urlString = product?.thumbnail, let url = URL(string: urlString) {
            productImageView.loadImage(from: url)
        } else {
           
                self.productImageView.image = UIImage(named: "placeholder")
            
        }
        productNameLabel.text = product?.title ?? "NA"
        productDescriptionLabel.text = product?.description ?? "NA"
        
        productPriceLabel.text = "$ \(product?.price ?? 0.0)"
        soldByLabel.text = product?.brand ?? "NA"
    }
}
