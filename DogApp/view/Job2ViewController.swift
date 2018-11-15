//
//  Job2ViewController.swift
//  DogApp
//
//  Created by Thắng Nguyễn Hoàng on 7/30/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView
import MessageUI
class Job2ViewController: UIViewController,MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    func showAlert1(msg:String,view:UIViewController){
        // Create the alert controller
        let alertController = UIAlertController(title: "Thông Báo", message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style:.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            let Googlemap = self.storyboard?.instantiateViewController(withIdentifier: "googlemap")
            self.present(Googlemap!, animated: true, completion: nil)
        }
        
        alertController.addAction(okAction)
        view.present(alertController, animated: true, completion: nil)
    }

    @IBOutlet weak var lblLoaiDichVu: UILabel!
    @IBOutlet weak var lblDiemDen: UILabel!
    @IBOutlet weak var lblMoTa: UILabel!
    @IBOutlet weak var lblGhiChu: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    var seconds: Int = 10
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    var data:[Order]?
    var indexPage = 0
    @IBOutlet weak var navi: UINavigationItem!
    @IBAction func back(_ sender: Any) {
        indexPage = indexPage - 1
        if(indexPage<0){
            indexPage = (data?.count)! - 1
        }
        updateData()
        
    }
    @IBAction func next(_ sender: Any) {
        indexPage = indexPage + 1
        if(indexPage>=(data?.count)!){
            indexPage = 0
        }
        updateData()
    }
    
    func updateData(){
        let ser = data![indexPage].service_id
        
        lblLoaiDichVu.text = "Loại Dịch Vụ: \((data![indexPage].service)!)"
        
        lblDiemDen.text = "\((data![indexPage].pickup?.address)!)"
        lblMoTa.text = "\((data![indexPage].description)!)"
        lblGhiChu.text = "\((data![indexPage].note)!)"
        let count:Int = (data?.count)!
        navi.title = "\(indexPage+1)/\(count)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        
    }
    @IBAction func btnNhanViec(_ sender: UIButton) {
        //        let googleMap = self.storyboard?.instantiateViewController(withIdentifier: "googlemap")
        //        self.present(googleMap!, animated: true, completion: nil)
        let time = timePicker.date
        let gio = Calendar.current.component(.hour, from: time)
        let phut = Calendar.current.component(.minute, from: time)
        print("gio:\(gio):\(phut)")
        
        if (seconds < 1) {
            showAlert(msg: "Đã quá thời gian, bạn không thể nhận đơn hàng", view: self)
        } else {
            
            let headers: HTTPHeaders = [
                "X-API-KEY": "\(tokenlogin)",
                "Accept": "application/json"
            ]
            Alamofire.request("http://shipx.vn/api/index.php/VinterAcceptOrder/?order_id=\(MaDon)&hero_id=\(heroID)&res_time=\(gio):\(phut)",headers: headers).responseJSON {(response) in
                if(response.error == nil){
                    let Value = response.result.value as! NSDictionary
                    print(Value)
                    print(MaDon)
                    //
                    let Status = Value["status"] as! String
                    
                    if(Status == "success"){
                        _ = Value["phone_number"] as! String
                        let alertController = UIAlertController(title: "Thông Báo", message: "Bạn đã đặt lịch thành công", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default) {
                            UIAlertAction in
                            NSLog("OK Pressed")
                            self.requestNhanHang(hero_id: heroID, order_id: MaDon)
                            
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }else{
                        self.showAlert1(msg: "Lỗi, Công việc đã được nhận", view: self)
                    }
                }
            }
            
        }
        
        
    }
    func requestNhanHang(hero_id:String,order_id:String){
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        // print(test)
        Alamofire.request("http://shipx.vn/api/index.php/VinterWoking/?hero_id=\(hero_id)&order_id=\(order_id)&lat=0.0&long=0.0",headers: headers).responseJSON {(response) in
            if(response.error == nil){
                let Value = response.result.value as! NSDictionary
                
                let Status = Value["status"] as! String
                let response = Value["response"] as? Any
                //print("res",response)
                if(Status == "success"){
                    let alertController = UIAlertController(title: "Thông Báo", message: "Vui lòng liên hệ với khách hàng sớm nhất!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) {
                        UIAlertAction in
                        NSLog("OK Pressed")
                        let Googlemap = self.storyboard?.instantiateViewController(withIdentifier: "googlemap")
                        self.present(Googlemap!, animated: true, completion: nil)
                        _ = SCLAlertView.SCLAppearance(
                            showCloseButton: false
                        )
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    if (response as? String) != nil {
                        showAlert(msg: response as! String, view: self)
                    }else{
                        // showAlert(msg: "Có lỗi xảy ra!", view: self)
                    }
                    
                    print("loi.....")
                }
                DispatchQueue.main.async {
                    
                }
            }
        }
    }
    @IBAction func btnTuChoi(_ sender: UIButton) {
        let Googlemap = self.storyboard?.instantiateViewController(withIdentifier: "googlemap")
        self.present(Googlemap!, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
