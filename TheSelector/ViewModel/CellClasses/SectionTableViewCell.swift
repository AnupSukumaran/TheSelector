//
//  SectionTableViewCell.swift
//  TheSelector
//
//  Created by Sukumar Anup Sukumaran on 12/09/20.
//  Copyright © 2020 Manu Puthoor. All rights reserved.
//

import UIKit

class SectionTableViewCell: UITableViewCell {

    @IBOutlet weak var sectionTitleLB: UILabel!
    var cellModel: CellConfigProtocol? {
        didSet {
            guard let model = cellModel as? SectionTableViewCellModel else {return}
            sectionTitleLB.text = model.titleStr
        }
    }
}
