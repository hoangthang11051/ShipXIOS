//
//  HistoryCell1.swift
//  DogApp
//
//  Created by Admin on 10/13/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class HistoryCell1: UITableViewCell {
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblsoTien: UILabel!
    @IBOutlet weak var lblMadon: UILabel!
    @IBOutlet weak var lblLoaiDichVu: UILabel!
    @IBOutlet weak var lblTienNhanDuoc: UILabel!
    
    @IBOutlet weak var lblThuHo: UILabel!
    @IBOutlet weak var lblTienthu: UILabel!
    @IBOutlet weak var lblPhiShip: UILabel!
    @IBOutlet weak var lblTenshop: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
