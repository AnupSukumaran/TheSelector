//
//  TextTableViewCell.swift
//  TheSelector
//
//  Created by Sukumar Anup Sukumaran on 12/09/20.
//  Copyright © 2020 Manu Puthoor. All rights reserved.
//

import UIKit
import DropDown

class TextTableViewCell: UITableViewCell {

    @IBOutlet weak var mainLB: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    
    let dropDown = DropDown()
    var textStrArr = [String]()
    var menuSelection: ((Int, String) -> ())?
    var menuBtnActionHandler: ((_ errorStr: String) -> ())?
    var cellModel: CellConfigProtocol? {
        didSet {
            guard let model = cellModel as? TextTableViewCellModel else {return}
            textStrArr = model.textStrArr
            configCellMenu()
        }
    }
    
    var viewModel: HomeViewModel! {
        didSet {
            viewModel.textStrArr = textStrArr
        }
    }
    
    var textStrVal: String = "-" {
        didSet {
            mainLB.text = textStrVal
        }
    }
    
    @IBAction func menuBtnAction(_ sender: UIButton) {
        guard !viewModel.menuDataSource.isEmpty else {menuBtnActionHandler?(.selectedTxt);return}
        dropDown.show()
    }

}

extension TextTableViewCell {
    func configCellMenu() {

        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            cell.optionLabel.textAlignment = .center
        }
        
        dropDown.width = menuBtn.frame.width + 10
        dropDown.anchorView = menuBtn
        dropDown.direction = .bottom
        dropDown.dismissMode = .onTap
        dropDown.bottomOffset = CGPoint(x: -5, y:(dropDown.anchorView?.plainView.bounds.height)!)
    }
}
