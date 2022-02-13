//
//  ViewController+loadNib.swift
//  ThirdwayTask
//
//  Created by Mohamed Hasseb on 27/01/2022.
//

import UIKit

extension UIViewController {
    static func instantiateFromNib() -> Self? {
        func instantiateFromNib<T: UIViewController>(_ viewType: T.Type) -> T? {
            return Bundle.main.loadNibNamed(String(describing: T.self),
                                     owner: nil, options: nil)?.first as? T
        }
        return instantiateFromNib(self)
    }
}
