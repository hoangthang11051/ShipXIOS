//
//  WorkingCell2.swift
//  DogApp
//
//  Created by Thắng Nguyễn Hoàng on 7/31/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class WorkingCell2: UITableViewCell {
    
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var nhanhang: UIButton!
    @IBOutlet weak var giaohang: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
