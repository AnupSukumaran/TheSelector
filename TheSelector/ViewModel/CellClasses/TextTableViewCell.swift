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
    
    var cellModel: CellConfigProtocol? {
        didSet {
            guard let model = cellModel as? TextTableViewCellModel else {return}
            textStrArr = model.textStrArr
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCellMenu()
        
    }
    
    @IBAction func menuBtnAction(_ sender: UIButton) {
        dropDown.show()
    }

}

extension TextTableViewCell {
    func configCellMenu() {
        dropDown.dataSource  = ["1","2","3"]
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            cell.optionLabel.textAlignment = .center
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
        }
        dropDown.width = menuBtn.frame.width + 10
        dropDown.anchorView = menuBtn
        dropDown.direction = .bottom
        dropDown.dismissMode = .onTap
        dropDown.bottomOffset = CGPoint(x: -5, y:(dropDown.anchorView?.plainView.bounds.height)!)
    }
}
