//
//  TextTableViewCellModel.swift
//  TheSelector
//
//  Created by Sukumar Anup Sukumaran on 12/09/20.
//  Copyright © 2020 Manu Puthoor. All rights reserved.
//

import Foundation

class TextTableViewCellModel: CellConfigProtocol {
    
    var cellType: CellType {
        return .jumbled
    }
    
    var rowCount: Int {
        return textStrArr.count
    }
    
    var textStrArr = [String]()
    init(textStrArr: [String]) {
        self.textStrArr = textStrArr
    }
    
}

class SectionTableViewCellModel: CellConfigProtocol {
    var cellType: CellType {
        return .section
    }
    
    var rowCount: Int {
        return 1
    }
    
    var titleStr: String
    
    init(titleStr: String) {
        self.titleStr = titleStr
    }
    
}

class SelectedItemTableViewCellModel: CellConfigProtocol {
    
    var cellType: CellType {
        return .ordered
    }

    var rowCount: Int {
        return textStrArr.count
    }
    
    var textStrArr = [String]()
    init(textStrArr: [String]) {
        self.textStrArr = textStrArr
    }
    
}

