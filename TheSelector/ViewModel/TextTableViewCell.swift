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
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        // Will set a custom width instead of the anchor view width
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func menuBtnAction(_ sender: UIButton) {
       
        dropDown.show()
    }

}
