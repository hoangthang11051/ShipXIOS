//
//  ThongKe.swift
//  DogApp
//
//  Created by Admin on 10/13/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ThongKe: UIViewController {

    @IBOutlet weak var dataStart: UIDatePicker!
    @IBOutlet weak var dataEnd: UIDatePicker!
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func btnThongKe(_ sender: UIButton) {
        
        let dateFm = DateFormatter()
        dateFm.dateFormat = "dd/MM/yyyy"
        let a = dateFm.string(from: dataStart.date)
        let b = dateFm.string(from: dataEnd.date)
        let history1 = storyboard?.instantiateViewController(withIdentifier: "history1") as! history1
        
        self.present(history1, animated: true, completion: nil)
    }
    
    
}
