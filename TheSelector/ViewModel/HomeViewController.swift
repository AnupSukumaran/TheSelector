//
//  HomeViewController.swift
//  TheSelector
//
//  Created by Sukumar Anup Sukumaran on 12/09/20.
//  Copyright © 2020 Manu Puthoor. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var homeViewModel: HomeViewModelProtocol? {
        didSet {
            callingHandlers()
        }
    }

}

//MARK: Life Cycle
extension HomeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel?.configTable(table: tableView)
        homeViewModel?.callingHomeAPI()
    }
    
}

//MARK: functions
extension HomeViewController {
    func callingHandlers() {
        homeViewModel?.successHandler = { [weak self] in
            self?.tableView.reloadData()
        }
        
        homeViewModel?.errorHandler = { errorStr in
            print("error = \(errorStr)")
            UIAlertController.showAlert(title: .appName, message: errorStr, buttonTitle: .ok, selfClass: self)
        }
    }
}
