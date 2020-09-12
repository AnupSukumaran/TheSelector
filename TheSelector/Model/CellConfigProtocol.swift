//
//  CellConfigProtocol.swift
//  TheSelector
//
//  Created by Sukumar Anup Sukumaran on 12/09/20.
//  Copyright © 2020 Manu Puthoor. All rights reserved.
//

import Foundation

enum CellType {
    case jumbled
    case section
    case ordered
}

protocol CellConfigProtocol: class {
    var cellType: CellType { get }
    var rowCount: Int { get }
}
