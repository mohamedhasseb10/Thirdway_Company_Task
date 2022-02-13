//
//  ProductListCollectionViewCell.swift
//  ThirdwayTask
//
//  Created by Mohamed Hasseb on 28/01/2022.
//


import UIKit

class ProductListCollectionViewCell: UICollectionViewCell {
    // MARK: - Define Object UI
    var productImage : UIImageView = {
      let img = UIImageView()
      img.contentMode = .scaleAspectFill
      img.clipsToBounds = true
      img.translatesAutoresizingMaskIntoConstraints = false
      img.setContentHuggingPriority(.defaultLow, for: .vertical)
      return img
    }()
    
    var productPriceLabel : UILabel = {
        let lab = UILabel()
        lab.textAlignment = .center
        lab.textColor = .black
        lab.numberOfLines = 0
        lab.lineBreakMode = .byWordWrapping
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        lab.setContentHuggingPriority(.defaultHigh, for: .vertical)
       return lab
    }()
    
    var productDescriptionLabel : UILabel = {
        let lab = UILabel()
        lab.textAlignment = .center
        lab.textColor = .black
        lab.numberOfLines = 0
        lab.lineBreakMode = .byWordWrapping
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.font = UIFont(name: "Helvetica", size: 16)
        lab.setContentHuggingPriority(.defaultHigh, for: .vertical)
       return lab
    }()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemCell = nil
        productImage.removeFromSuperview()
        productPriceLabel.removeFromSuperview()
        productDescriptionLabel.removeFromSuperview()
    }
    
    deinit {
        itemCell = nil
    }
    // MARK: - SetViews
    func setupViews(){
        layer.borderWidth = 1
        layer.borderColor =  UIColor.lightGray.cgColor
        backgroundColor = .white
        contentView.addSubview(productImage)
        contentView.addSubview(productPriceLabel)
        contentView.addSubview(productDescriptionLabel)
    }
    // MARK: - SetConstrains
    func setupConstraints(){
        productImage.anchor(top: contentView.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: contentView.leadingAnchor, paddingLeft: 0, right: contentView.trailingAnchor, paddingRight: 0, width: 0, height: 0)
        productPriceLabel.anchor(top: productImage.bottomAnchor , paddingTop: 5, bottom: productDescriptionLabel.topAnchor, paddingBottom: -5, left: contentView.leadingAnchor, paddingLeft: 5, right: contentView.trailingAnchor, paddingRight: -5, width: 0, height: 0)
        productDescriptionLabel.anchor(top: productPriceLabel.bottomAnchor , paddingTop: 5, bottom: contentView.bottomAnchor, paddingBottom: -5, left: contentView.leadingAnchor, paddingLeft: 5, right: contentView.trailingAnchor, paddingRight: -5, width: 0, height: 0)
    }
    // MARK: - SetCell
    var itemCell: ProductItem? {
           didSet {
               guard let productPrice = itemCell?.price else {return}
               productPriceLabel.text = "\(productPrice)$"
               guard let productDescription = itemCell?.productDescription else {return}
               self.productDescriptionLabel.text = productDescription
               guard let url = URL(string: itemCell?.image?.url ?? "") else {return}
               self.productImage.download(from: url)
           }
       }
}
