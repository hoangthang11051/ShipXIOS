//
//  HenGiaoViewController.swift
//  DogApp
//
//  Created by Admin on 10/23/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
class HenGiaoViewController: UIViewController {

    @IBOutlet weak var btnHen: UIButton!
    @IBOutlet weak var lblLydo: UITextField!
    @IBOutlet weak var btnGui: UIButton!
    @IBOutlet weak var btnTrashop: UIButton!
    func showAlert1(msg:String,view:UIViewController){
        let alertController = UIAlertController(title: "Thông Báo", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {
            UIAlertAction in
            NSLog("OK Pressed")
            let JobWorking = self.storyboard?.instantiateViewController(withIdentifier: "jobworking")
            self.present(JobWorking!, animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        view.present(alertController, animated: true, completion: nil)
    }
    @IBOutlet weak var timePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(ser != "3"){
            btnTrashop.setTitle("Đơn hàng thất bại", for: .normal)
        }
    }
    @IBAction func btnGuiShop(_ sender: Any) {
        let des = lblLydo.text
        
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("https://shipx.vn/api/index.php/Refund/?order_id=\(order1!)&hero_id=\(heroID)&description=\(des!)",headers: headers).responseJSON {(response) in
            let Value1 = response.result.value as! NSDictionary
           
            if(response.error == nil){
                let Value = response.result.value as! NSDictionary
                print("hihi",Value)
                let Status = Value["status"] as! String
                if(Status == "success"){
                    
                    let res = Value["response"] as! String
                    self.showAlert1(msg: res, view: self)
                }
            }
        }
    }
    
    @IBAction func btnHenTgian(_ sender: Any) {

        let timeNgay = DateFormatter()
        timeNgay.dateFormat = "dd/MM/yyyy"
        let a = timeNgay.string(from: timePicker.date)
        print(a)
        let timeNgay1 = DateFormatter()
        timeNgay1.dateFormat = "HH:mm"
        let b = timeNgay1.string(from: timePicker.date)
        print(b)
                let headers: HTTPHeaders = [
                    "X-API-KEY": "\(tokenlogin)",
                    "Accept": "application/json"
                ]
                Alamofire.request("http://shipx.vn/api/index.php/ChangeDate/?hero_id=\(heroID)&order_id=\(order1!)&date=\(a)&time=0\(b)",headers: headers).responseJSON {(response) in
                    
                    if(response.error == nil){
                        let Value = response.result.value as! NSDictionary
                        let Status = Value["status"] as! String
                        if(Status == "success"){
        
                            let res = Value["response"] as! String
                            self.showAlert1(msg: res, view: self)
                        }
                    }
                }
    }
    @IBAction func btnKhongll(_ sender: Any) {
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("https://shipx.vn/api/index.php/MissingCall/?order_id=\(order1!)&hero_id=\(heroID)",headers: headers).responseJSON {(response) in
            let Value1 = response.result.value as! NSDictionary
            print("hihi",Value1)
            if(response.error == nil){
                let Value = response.result.value as! NSDictionary
                print("hihi",Value)
                let Status = Value["status"] as! String
                if(Status == "success"){
                    
                    let res = Value["response"] as! String
                    self.showAlert1(msg: res, view: self)
                }
            }
        }
          print("huhu")
    }
    @IBAction func btnThaydoi(_ sender: Any) {
        timePicker.isHidden = false
        btnHen.isHidden = false
        btnGui.isHidden = true
        lblLydo.isHidden = true
        
    }
    
    @IBAction func btnTraShop(_ sender: Any) {
        timePicker.isHidden = true
        btnHen.isHidden = true
        btnGui.isHidden = false
        lblLydo.isHidden = false
        
    }
    
}
