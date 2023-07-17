//
//  ProductViewController.swift
//  Login
//
//  Created by Hanh Vo on 6/13/23.
//

import UIKit

class ProductViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    var viewModel = ProductListViewModel()
    var searchController: UISearchController!
    
   
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var cetegoryPickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        setupOverlayView()
        setUpSearchController()
        getData()
        getCategories()
    }
    
    //MARK: - Setup UI
    
    private func setupOverlayView(){
       // hidePicker()
   
        pickerContainerView.isHidden = true
        
        cetegoryPickerView.delegate = self
        cetegoryPickerView.dataSource = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hidePicker))
      // overlayView.addGestureRecognizer(tapGesture)
    }
    
    func setUpSearchController(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search products"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    //MARK: - Buttons
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        hidePicker()
    }
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        let choiceIndex = cetegoryPickerView.selectedRow(inComponent: 0)
        //let selectedCategory = ProductCategory.allCases[choiceIndex]
        let selectedCategory = viewModel.categories[choiceIndex]
        self.fetchProductByCategory(selectedCategory)
        hidePicker()
    }
    

    @objc func hidePicker() {
        // Hide the overlay and picker views when overlay is tapped
        UIView.animate(withDuration: 0.3, animations: {
            
            self.pickerContainerView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            
            self.pickerContainerView.isHidden = true
        }
    }

    @IBAction func chooseCategoryButtonTapped(_ sender: Any) {
       
        pickerContainerView.isHidden = false
        
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerContainerView.transform = CGAffineTransform.identity
            
        })
    }
    
    
    @IBAction func addProductButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // replace "Main" with the name of your storyboard
        if let secondViewController = storyboard.instantiateViewController(withIdentifier: "addProductVC") as? AddProductViewController {
            secondViewController.modalPresentationStyle = .pageSheet // or any other style
            present(secondViewController, animated: true, completion: nil)
        }
    }
    

    //MARK: - Fetch Data
    private func fetchProductByCategory(_ category: String) {
        viewModel.fetchProductByCategory(category: category) { apiError in
            if let error = apiError {
                self.presentAlert(message: error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func getCategories(){
        viewModel.fetchCategories {[weak self] apiError in
            if let error = apiError {
                DispatchQueue.main.async {
                    self?.presentAlert(message: error.localizedDescription)
                }
            } else {
                DispatchQueue.main.async {
                    self?.cetegoryPickerView.reloadAllComponents()
                }
            }
        }
    }


    private func getData(){
        viewModel.fetchProducts { [weak self] apiError in
            if let error = apiError {
                DispatchQueue.main.async {
                    self?.presentAlert(message: error.localizedDescription)
                }
            } else {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            
        }
    }
}

//MARK: - Extensions

extension ProductViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductTableViewCell
        let product = viewModel.productAtIndex(indexPath.row)
        cell.configure(with: product)
        return cell
    }
    
}

extension ProductViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}


extension ProductViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased(), !searchText.isEmpty else {
            getData()
            return
            
        }
        self.viewModel.fetchProducts(by: searchText) { apiError in
            if let error = apiError{
                self.presentAlert(message: error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - UIPicker  extension

extension ProductViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard !viewModel.categories.isEmpty && row < viewModel.categories.count else {
            return nil
        }
        return viewModel.categories[row]
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productID = viewModel.productAtIndex(indexPath.row).id
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? ProductDetailViewController else {
            fatalError("cannot instantiate DetailVC")
        }
        
        detailVC.viewModel = ProductDetailViewModel()
        detailVC.viewModel.fetchProductDetails(productID: productID) { error in
            if let error = error {
                self.presentAlert(message: error.localizedDescription)
            }
        }
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

