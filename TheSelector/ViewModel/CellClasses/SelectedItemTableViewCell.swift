//
//  SelectedItemTableViewCell.swift
//  TheSelector
//
//  Created by Sukumar Anup Sukumaran on 12/09/20.
//  Copyright © 2020 Manu Puthoor. All rights reserved.
//

import UIKit

class SelectedItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var indexLB: UILabel!
    @IBOutlet weak var itemTxt: UILabel!
    @IBOutlet weak var eraseBtn: UIButton!
    
    var eraseBtnHandler: (() -> ())?
    var textStrArr = [String]()
    
//    var cellModel: CellConfigProtocol? {
//        didSet {
//            guard let model = cellModel as? SelectedItemTableViewCellModel else {return}
//            textStrArr = model.textStrArr
//        }
//    }
//    
//    var viewModel: HomeViewModel! {
//        didSet {
//            viewModel.selectedTextArr = textStrArr
//        }
//    }
    
    var textStrVal: String = "-" {
        didSet {
            itemTxt.text = textStrVal
        }
    }
    
    @IBAction func eraseBtnAction(_ sender: UIButton) {
        eraseBtnHandler?()
    }

}
