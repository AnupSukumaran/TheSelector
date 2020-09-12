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
        
    var textStrVal: String = "-" {
        didSet {
            itemTxt.text = textStrVal
            eraseBtn.isHidden = itemTxt.text == "" 
        }
    }
    
    @IBAction func eraseBtnAction(_ sender: UIButton) {
        eraseBtnHandler?()
    }

}
