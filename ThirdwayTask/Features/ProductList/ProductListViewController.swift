//
//  ProductListViewController.swift
//  ThirdwayTask
//
//  Created by Mohamed Hasseb on 27/01/2022.
//

import UIKit

class ProductListViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var productListCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // MARK: - Controller Variables
    var viewModel = ProductListViewModel()
    let layout = PinterestLayout()
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        regiserNib()
        configure()
        createBinding()
        viewModel.getProductList(withLoader: true)
    }
    // MARK: - RegisterNib
    func regiserNib() {
        productListCollectionView.register(ProductListCollectionViewCell.self, forCellWithReuseIdentifier: "ProductListCollectionViewCell")
    }
    // MARK: - Initial Configuration
    func configure(){
        layout.delegate = self
        self.navigationController?.delegate = self
        productListCollectionView.dataSource = self
        productListCollectionView.delegate = self
        productListCollectionView.collectionViewLayout = layout
    }
    // MARK: - Naive Binding
    func createBinding() {
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.viewModel.state {
                case .empty, .error:
                    self.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.productListCollectionView.alpha = 0.0
                    })
                case .loading:
                    self.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.productListCollectionView.alpha = 0.0
                    })
                case .populated:
                    self.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.productListCollectionView.alpha = 1.0
                    })
                }
            }
        }
        
        viewModel.reloadCollectionViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.productListCollectionView.reloadData()
            }
        }
    }
    // MARK: - Alert
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ProductListViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =
                productListCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCollectionViewCell",
                                                              for: indexPath) as? ProductListCollectionViewCell else {
                    fatalError("Cell not exists in storyboard")
                }
        let cellItem = viewModel.getProductItem(at: indexPath.row)
        cell.itemCell = cellItem
        return cell
    }
}
extension ProductListViewController: UICollectionViewDelegate, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let productDetailsController = ProductDetailsViewController.instantiateFromNib() {
            let product = self.viewModel.getProductItem(at: indexPath.row)
            self.navigate(to: productDetailsController, with: product)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.viewModel.numberOfCells - 1 {
            self.viewModel.getProductList()
        }
    }
    // MARK: - Navigation
    func navigate(to viewController: ProductDetailsViewController, with item: ProductItem) {
        let detailsViewModel = ProductDetailsViewModel(item)
        viewController.viewModel = detailsViewModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ProductListViewController : PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
        let item = self.viewModel.getProductItem(at: indexPath.row)
        let imgHeight = calculateImageHeight(sourceImage: item, scaledToWidth: cellWidth)
        let priceHeight = requiredHeight(text: String(item.price!), cellWidth: (cellWidth - 10))
        let descriptionHeight = requiredHeight(text: item.productDescription!, cellWidth: (cellWidth - 10))
        return (imgHeight + priceHeight + descriptionHeight + 20)
    }
    // MARK: - Calculate Image Height
    func calculateImageHeight (sourceImage: ProductItem, scaledToWidth: CGFloat) -> CGFloat {
        let oldWidth = CGFloat( (sourceImage.image?.width)!)
        let scaleFactor = scaledToWidth / oldWidth
        let newHeight = CGFloat((sourceImage.image?.height)!) * scaleFactor
        return newHeight
    }
    // MARK: - Calculate String Height Base On Content
    func requiredHeight(text:String , cellWidth : CGFloat) -> CGFloat {
        let font = UIFont(name: "Helvetica", size: 16.0)
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: cellWidth, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}

extension ProductListViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation()
    }
}
