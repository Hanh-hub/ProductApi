//
//  ViewController.swift
//  Login
//
//  Created by Hanh Vo on 6/9/23.
//

// LoginViewController.swift
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: LoginViewModel!
    
    init(viewModel: LoginViewModel = LoginViewModel()){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        self.viewModel = LoginViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.text = "kminchelle"
        passwordTextField.text = "0lelplR"
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton){
       //validateInput()
        viewModel.username = usernameTextField.text ?? ""
        viewModel.password = passwordTextField.text ?? ""
        login()
    }
    
    func login(){
        activityIndicator.isHidden = false
        viewModel.login {[weak self] result in
            DispatchQueue.main.async {
                self?.activityIndicator.isHidden = true
                
                switch result {
                case .success(_):
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    guard let productVC = storyboard.instantiateViewController(withIdentifier: "ProductVC") as? ProductViewController else {
                        print("Could not instantiate DashboardVC")
                        return
                    }
                    
                    self?.navigationController?.pushViewController(productVC, animated: true)
                case .failure(let error):
                    self?.presentAlert(message: error.localizedDescription)
                }
            }
        }
    }
}


