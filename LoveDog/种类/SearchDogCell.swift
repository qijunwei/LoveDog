//
//  SearchDogCell.swift
//  LoveDog
//
//  Created by wei on 16/8/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class SearchDogCell: UITableViewCell {

    @IBOutlet weak var headImage: UIImageView!
    
    @IBOutlet weak var dogName: UILabel!{
        didSet{
            dogName.adjustsFontSizeToFitWidth = true
        }
    }
    
    @IBOutlet weak var detail: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dogName.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
