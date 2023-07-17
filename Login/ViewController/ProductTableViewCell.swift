//
//  ProductTableViewCell.swift
//  Login
//
//  Created by Hanh Vo on 6/13/23.
//

import UIKit
import Foundation

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var starImageView1: UIImageView!
    @IBOutlet weak var starImageView2: UIImageView!
    @IBOutlet weak var starImageView3: UIImageView!
    @IBOutlet weak var starImageView4: UIImageView!
    @IBOutlet weak var starImageView5: UIImageView!
    
    var starImageViews: [UIImageView] {
        return [starImageView1,
                starImageView2,
                starImageView3,
                starImageView4,
                starImageView5]
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    func configure(with product: Product){
        if let urlString = product.thumbnail, let url =  URL(string: urlString) {
            productImageView.loadImage(from: url)
        }
        
        priceLabel.text = "Now $\(product.price?.description ?? "NA")"
        titleLabel.text = product.title ?? "NA"
        updateStars(rating: product.rating ?? 0.0)
    }

    
    private func updateStars(rating: Double){
        let fullStars = Int(rating)
        let halfStars = rating - Double(fullStars) >= 0.5 ? 1 : 0

        for (index, star) in starImageViews.enumerated() {
            if index < fullStars {
                star.image = UIImage(systemName: "star.fill")
            } else if index == fullStars, halfStars > 0 {
                star.image = UIImage(systemName: "star.leadinghalf.filled")
            } else {
                star.image = UIImage(systemName: "star")
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

