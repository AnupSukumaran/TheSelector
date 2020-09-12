//
//  HomeViewModel.swift
//  TheSelector
//
//  Created by Sukumar Anup Sukumaran on 12/09/20.
//  Copyright © 2020 Manu Puthoor. All rights reserved.
//

import Foundation
import UIKit
import SASLoaderPod


protocol ViewModelProtocol: class {
    func configTable(table: UITableView)
}

protocol HomeViewModelProtocol: ViewModelProtocol, UITableViewDataSource, UITableViewDelegate {
    func callingHomeAPI()
    var successHandler: (() -> ())? { get set }
    var errorHandler: ((_ errorStr: String) -> ())? { get set }
}

class HomeViewModel: NSObject {
    
    var loader: LoaderView!
    var textStrArr = [String]()
    var menuDataSource = [String]()
    var cellModels = [CellConfigProtocol]()
    
    //MARK: properties from HomeViewModelProtocol protocol
    var successHandler: (() -> ())?
    var errorHandler: ((_ errorStr: String) -> ())?
    
    
    override init() {}
    init(loader: LoaderView) {
        self.loader = loader
    }
    
}

extension HomeViewModel {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("TextTableViewCell.identifier = \(TextTableViewCell.identifier)")
        
        let cellModel = cellModels[indexPath.section]
        
        switch cellModel.cellType {
        case .jumbled:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as? TextTableViewCell {
                cell.dropDown.dataSource = menuDataSource
                cell.cellModel = cellModel
                cell.viewModel = self
                cell.textStrVal = textStrArr[indexPath.row]
                cell.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                  print("Selected item: \(item) at index: \(index)")
                    guard !self.menuDataSource.isEmpty else { self.errorHandler?(.selectedTxt);return}
                    self.menuDataSource.remove(at: index)
                    self.successHandler?()
                }
            
               return cell
            }
            
        case .section:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SectionTableViewCell.identifier, for: indexPath) as? SectionTableViewCell {
                cell.cellModel = cellModel
               return cell
            }
        case .ordered: break
        }
        
       
        return UITableViewCell()
    }
    
    
}



extension HomeViewModel: HomeViewModelProtocol {
    
    func configTable(table: UITableView) {
        table.delegate = self
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 20
    }
    
    /// Calling Login API intstead of API call used DispatchQueue delay function
    func callingHomeAPI() {
        loader.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.loader.stopAnimating()
            
            if let localData = self.readLocalFile(forName: "TextData") {
                
                self.parse(jsonData: localData) { (response) in
                    switch response {
                    case .success(let data):
                        self.cellModels.removeAll()
                        if let txtData = data.textDataModel, !txtData.isEmpty {
                            self.menuDataSource = txtData.enumerated().map({ (i,_) in return "\(i+1)" })
                            let cModel = TextTableViewCellModel(textStrArr: data.textDataModel ?? [])
                            let sModel = SectionTableViewCellModel(titleStr: "Here the questions will be ordered in the correct sequence.")
                            self.cellModels.append(cModel)
                            self.cellModels.append(sModel)
                        }
                        self.successHandler?()
                    
                    case .failure(errorStr: let errStr):
                        self.errorHandler?(errStr)
                        
                    }
                }
            }
        
        }
    }
    
    
}

