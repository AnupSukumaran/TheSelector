//
//  TextTableViewCell.swift
//  TheSelector
//
//  Created by Sukumar Anup Sukumaran on 12/09/20.
//  Copyright © 2020 Manu Puthoor. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    @IBOutlet weak var mainLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        mainLB.textColor = .black
//        mainLB.backgroundColor = .gray
//        mainLB.layer.cornerRadius = 10
//        let insets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//        mainLB.drawText(in: CGRect().inset(by: insets))
//        mainLB.textColor = .black
//        mainLB.backgroundColor = .gray
//        mainLB.layer.cornerRadius = 10
//        mainLB.layer.masksToBounds = true
        
    }
    
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let insets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//        mainLB.drawText(in: CGRect().inset(by: insets))
//    }
//
//    override func draw(_ rect: CGRect) {
//        let insets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//        mainLB.drawText(in: CGRect().inset(by: insets))
//    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
