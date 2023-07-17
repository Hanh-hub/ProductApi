//
//  DashBoardViewController.swift
//  Login
//
//  Created by Hanh Vo on 6/9/23.
//

import UIKit


class DashboardViewController: UIViewController {
    var user: UserModel! 
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
   
    @IBOutlet weak var firstnameLabel: UILabel!
    
    @IBOutlet weak var lastnameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        configure()

    }
    
    func configure(){
        
        if let imageUrl = URL(string: user.image) {
            loadImage(from: imageUrl)
            self.profileImageView.layer.cornerRadius = 70
        }
        usernameLabel.text = user.username
        firstnameLabel.text = user.firstName
        lastnameLabel.text = user.lastName
        
        emailLabel.text = user.email
        genderLabel.text = user.gender
        
    }

    func loadImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                   
                    self?.profileImageView.image = image
                }
            }
        }
    }
}

