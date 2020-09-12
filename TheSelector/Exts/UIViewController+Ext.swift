//
//  UIViewController+Ext.swift
//  TheSelector
//
//  Created by Sukumar Anup Sukumaran on 12/09/20.
//  Copyright © 2020 Manu Puthoor. All rights reserved.
//

import UIKit
import SASLoaderPod

extension UIViewController {
    static let loader: (UIViewController) -> (LoaderView) = { (vc) in
        return LoaderView(callOn: vc, type: .lineScale, color: .red, padding: 25)
    }
    
    func loader() -> LoaderView {
        return UIViewController.loader(self)
    }
}
