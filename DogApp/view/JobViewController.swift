//
//  JobViewController.swift
//  DogApp
//
//  Created by Admin on 7/10/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
import MessageUI
import SCLAlertView

class JobViewController: UIViewController,MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var txtDiemNhan: UILabel!
    @IBOutlet weak var txtDiemGiao: UILabel!
    @IBOutlet weak var txtKhoangCach: UILabel!
    @IBOutlet weak var txtThoigian: UILabel!
    @IBOutlet weak var txtKhoiLuong: UILabel!
    @IBOutlet weak var txtPhiship: UILabel!
    @IBOutlet weak var txtMota: UILabel!
    @IBOutlet weak var txtGhichu: UILabel!
    
    func time(){
        let timeInterval = NSDate().timeIntervalSince1970
        print(timeInterval)
        //create_time_int
        let timeDat: String = data![indexPage].create_time_int!
        let time = Int(timeDat)! - Int(timeInterval)
        let time1 = Int(timeInterval) - Int(timeDat)!
        print(timeDat)
        seconds = time
        print(time)
        print(time1)
    }
    var seconds: Int = 0
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
        txtMota.text = "Mô tả: \((data![indexPage].description)!)"
        txtGhichu.text = "Ghi Chú: \((data![indexPage].note)!)"
        txtDiemNhan.text = data![indexPage].pickup?.address
        txtDiemGiao.text = data![indexPage].dropoff?.address
        txtKhoangCach.text = "Khoảng cách: \((data![indexPage].distance)!)Km"
        txtKhoiLuong.text = "Khối lượng: \((data![indexPage].weight)!)Kg"
        txtThoigian.text = "Giá trị: \((data![indexPage].money_first)!)đ"
        txtPhiship.text = "Phí Ship: \((data![indexPage].fee)!)đ"
        let count:Int = (data?.count)!
        navi.title = "\(indexPage+1)/\(count)"
        MaDon = data![indexPage].order_id!
        time()
        updateTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }
    func runTimer() {
      //  timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ChiTietCongViec.updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        if seconds < 1 {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
            timerLabel.textColor = UIColor.red
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
            timerLabel.textColor = UIColor.blue
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"⏰ %02i:%02i", hours, minutes, seconds)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateData()
    }
    func showAlert1(msg:String,view:UIViewController){
        // Create the alert controller
        let alertController = UIAlertController(title: "Thông Báo", message: msg, preferredStyle: .alert)
        
        // Create the actions
        //let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        let okAction = UIAlertAction(title: "OK", style:.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            let Googlemap = self.storyboard?.instantiateViewController(withIdentifier: "googlemap")
            self.present(Googlemap!, animated: true, completion: nil)
        }
        
        // Add the actions
        alertController.addAction(okAction)
        // Present the controller
        view.present(alertController, animated: true, completion: nil)
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
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
                print("res",response)
                if(Status == "success"){
                    let alertController = UIAlertController(title: "Thông Báo", message: "Vui lòng liên hệ với khách hàng sớm nhất!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) {
                        UIAlertAction in
                        NSLog("OK Pressed")
                        let Googlemap = self.storyboard?.instantiateViewController(withIdentifier: "googlemap")
                        self.present(Googlemap!, animated: true, completion: nil)
                        let appearance = SCLAlertView.SCLAppearance(
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
        //http://shipx.vn/api/index.php/VinterRemoveOrder/?order_id=567&hero_id=16
        
               // self.showAlert1(msg: "Bạn có chắc chắn không nhận đơn", view: self)
        let Googlemap = self.storyboard?.instantiateViewController(withIdentifier: "googlemap")
        self.present(Googlemap!, animated: true, completion: nil)
    }
}
