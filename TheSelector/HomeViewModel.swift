//
//  HomeViewModel.swift
//  TheSelector
//
//  Created by Sukumar Anup Sukumaran on 12/09/20.
//  Copyright © 2020 Manu Puthoor. All rights reserved.
//

import Foundation
import UIKit

protocol ViewModelProtocol: class {
    func configTable(table: UITableView)
}

class HomeViewModel: NSObject {
    
    override init() {}
    
}


extension HomeViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("TextTableViewCell.identifier = \(TextTableViewCell.identifier)")
        if let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as? TextTableViewCell {
            cell.mainLB.text = "TestIng"
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension HomeViewModel: ViewModelProtocol {
    
    func configTable(table: UITableView) {
        table.delegate = self
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 20
    }
    
    
}

extension NSObject {
    static var identifier: String {
        return String(describing: self)
    }
    
    func injectInitalViewModel(window: UIWindow?) {
        if let navVC = window?.rootViewController as? UINavigationController {
            if let vc = navVC.topViewController as? HomeViewController {
                vc.homeViewModel = HomeViewModel()
            }
        }
    }
}
