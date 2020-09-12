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

///Common protocol for all view models if needed
protocol ViewModelProtocol: class {
    func configTable(table: UITableView)
}

/// Protocol for HomeViewModel
protocol HomeViewModelProtocol: ViewModelProtocol, UITableViewDataSource, UITableViewDelegate {
    func callingHomeAPI()
    var successHandler: (() -> ())? { get set }
    var errorHandler: ((_ errorStr: String) -> ())? { get set }
    func resetAllActions()
}

class HomeViewModel: NSObject {
    
    var loader: LoaderView!
    var textStrArr = [String]()
    var menuDataSource = [String]()
    var selectedTextArr = [String]()
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
   
}

//MARK: TableView methods
extension HomeViewModel {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellModel = cellModels[indexPath.section]
        
        switch cellModel.cellType {
        case .jumbled:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as? TextTableViewCell {
                cell.dropDown.dataSource = menuDataSource
                cell.cellModel = cellModel
                cell.viewModel = self
                cell.textStrVal = textStrArr[indexPath.row]
                cell.menuBtnActionHandler = errorHandler
                cell.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    self.dropDownSelectionAction(index, indexPath, item)
                }
            
               return cell
            }
            
        case .section:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SectionTableViewCell.identifier, for: indexPath) as? SectionTableViewCell {
                cell.cellModel = cellModel
               return cell
            }
            
        case .ordered:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SelectedItemTableViewCell.identifier, for: indexPath) as? SelectedItemTableViewCell {
                cell.indexLB.text = "\(indexPath.row + 1)."
                cell.textStrVal = selectedTextArr[indexPath.row]
                cell.eraseBtnHandler = { [weak self] in
                    guard let vc = self else {return}
                    vc.eraseAction(indexPath)
                }
               return cell
            }
        }
        
       
        return UITableViewCell()
    }
    
    
}

// MARK: functions
extension HomeViewModel {
    /// Action to erase selected texts
    func eraseAction(_ indexPath: IndexPath) {
        menuDataSource.append("\(indexPath.row + 1)")
        menuDataSource.sort()
        selectedTextArr[indexPath.row] = ""
        successHandler?()
    }
    
    /// Drop down action
    func dropDownSelectionAction(_ index: Int,_ indexPath: IndexPath,_ item: String) {
        menuDataSource.remove(at: index)
        if let indVal = Int(item) {
           selectedTextArr[indVal-1] = textStrArr[indexPath.row]
        }
        successHandler?()
    }
}



extension HomeViewModel: HomeViewModelProtocol {
    
    ///function to refresh view
    func resetAllActions() {
       self.menuDataSource = textStrArr.enumerated().map({ (i,_) in return "\(i+1)" })
       selectedTextArr.removeAll()
       textStrArr.forEach { _ in selectedTextArr.append("") }
       self.successHandler?()
    }
    
    //Configuring TableView
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
                            let sModel = SectionTableViewCellModel(titleStr: .sectionTitle)
                            
                            txtData.forEach { _ in self.selectedTextArr.append("") }
            
                            let selectedModel = SelectedItemTableViewCellModel(textStrArr: self.selectedTextArr)
                            self.cellModels.append(cModel)
                            self.cellModels.append(sModel)
                            self.cellModels.append(selectedModel)
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

