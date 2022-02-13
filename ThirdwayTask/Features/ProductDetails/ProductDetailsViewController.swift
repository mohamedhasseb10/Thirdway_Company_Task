//
//  ProductDetailsViewController.swift
//  ThirdwayTask
//
//  Created by Mohamed Hasseb on 27/01/2022.
//

import UIKit
/**
 
     The Class was desined and implemented to show Product Details Screen.
 
     - **Extends Class:** SuperClass: UIViewController
     - **Co-Classes:** AppDelegate
*/

class ProductDetailsViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var productDescriptionTextView: UITextView!
    @IBOutlet weak var productImageView: UIImageView!
    // MARK: - Controller Variables
    var viewModel: ProductDetailsViewModel!
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    // MARK: - Update Details UI
    /**
    This function update Details Screen UI
    - parameters:
    - No Paramters
    - returns: No Return
    */
    func updateUI() {
        guard let url = URL(string: viewModel.productSelected.image?.url ?? "") else {return}
        productImageView.download(from: url)
        guard let productDescription = viewModel.productSelected.productDescription else {return}
        productDescriptionTextView.text = productDescription
    }
}
