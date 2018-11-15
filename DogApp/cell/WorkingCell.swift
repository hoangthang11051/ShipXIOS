//
//  WorkingCell.swift
//  DogApp
//
//  Created by Admin on 7/13/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class WorkingCell: UITableViewCell {
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var nhanhang: UIButton!
    @IBOutlet weak var giaohang: UIButton!
    @IBOutlet weak var txtSDT: UILabel!
    @IBOutlet weak var txtDiemGiao: UILabel!
    @IBOutlet weak var txtTenShop: UILabel!
    @IBOutlet weak var btnChitiet: UIButton!
    @IBOutlet weak var txtNguoiNhan: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
