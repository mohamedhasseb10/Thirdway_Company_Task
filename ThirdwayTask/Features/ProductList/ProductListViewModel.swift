//
//  ProductListViewModel.swift
//  ThirdwayTask
//
//  Created by Mohamed Hasseb on 28/01/2022.
//

import UIKit

class ProductListViewModel {
    // MARK: - Variables
    let repository: ProductListRepository
    // MARK: - callback for interfaces
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    private var cellViewModels: [ProductItem] = [ProductItem]() {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }
    var numberOfCells: Int {
        return cellViewModels.count
    }
    var reloadCollectionViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    // MARK: - init
    public init (_ repo: ProductListRepository = ProductListRepository()) {
        repository = repo
    }
    // MARK: - GetProductsList
    func getProductList(withLoader: Bool = false) {
        if withLoader {
            self.state = .loading
        }
        repository.getProductList { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                if let data = data as? ProductListModel {
                        self.updateView(with: data)
                }
            case .failure(let error):
                self.state = .error
                self.alertMessage = error.localizedDescription
            }
        }
    }
    // MARK: - GetItem
    func getProductItem(at index: Int) -> ProductItem {
        return cellViewModels[index]
    }
    // MARK: - UpdateViews
    func updateView(with dataList: ProductListModel) {
        self.cellViewModels += dataList.items
        self.state = .populated
    }
}
