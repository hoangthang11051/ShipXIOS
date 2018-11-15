//
//  ChiTietCongViec.swift
//  DogApp
//
//  Created by Admin on 7/13/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire

class ChiTietCongViec: UIViewController {
//    func time(){
//        let timeInterval = NSDate().timeIntervalSince1970
//        print(timeInterval)
//        let timeDat: String = (order?.create_time_int!)!
//        let time = Int(timeDat)! - Int(timeInterval)
//        let time1 = Int(timeInterval) - Int(timeDat)!
//        print(timeDat)
//        seconds = time
//        print(time)
//        print(time1)
//    }
    
    var seconds: Int = 0
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    @IBOutlet weak var lbSDTShop: UIButton!
    @IBOutlet weak var lbSDTKhach: UIButton!
    
    @IBAction func banDo(_ sender: Any) {
        let bando = storyboard?.instantiateViewController(withIdentifier: "bando") as! BanDoCongViec
       // bando.order = self.order
        self.present(bando, animated: true, completion: nil)
    }
    
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
       // homepage
        
    }
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
   // @IBOutlet weak var diemnhan: UILabel!
    @IBOutlet weak var diemgiao1: UILabel!
   // @IBOutlet weak var khoangcach: UILabel!
    @IBOutlet weak var sodienthoai: UILabel!
    @IBOutlet weak var sdtnguoinhan: UILabel!
    @IBOutlet weak var yeucau: UILabel!
    @IBOutlet weak var tienthuho: UILabel!
    @IBOutlet weak var Tongtien: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diemgiao1.text = "Điểm Giao: \(diemGiao!)"
        tienthuho.text = "Tiền Thu Hộ: \(tienThuHo!)"
        Tongtien.text = "Tổng Tiền: \(tongTien!)"
        lbSDTShop.setTitle("\(SDTKhach!)", for: .normal)
        lbSDTKhach.setTitle("\(SDTShop!)", for: .normal)
        yeucau.text = "Yêu cầu: \(YeuCau!)"
    }
    
    @IBAction func btnThanhCong(_ sender: Any) {
//            var hero = order?.hero_id
//            var order1 = order?.order_id
            print("https://shipx.vn/api/index.php/OrderSuccess/?hero_id=\(hero!)&order_id=\(order1!)&lat=123&long=123")
            let headers: HTTPHeaders = [
                "X-API-KEY": "\(tokenlogin)",
                "Accept": "application/json"
            ]
            Alamofire.request("https://shipx.vn/api/index.php/OrderSuccess/?hero_id=\(hero!)&order_id=\(order1!)&lat=123&long=123",headers: headers).responseJSON {(response) in
                print("huhu")
                if(response.error == nil){
                    let Value = response.result.value as! NSDictionary
                    let Status = Value["status"] as! String
                    let response = Value["response"] as! String
                    print("hihi")
                    print(Status)
                    if(Status == "success"){
                        let alertController = UIAlertController(title: "Thông Báo", message: "Cập nhật trạng thái đơn hàng thành công", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default) {
                            UIAlertAction in
                            NSLog("OK Pressed")
                            
                            self.dismiss(animated: true, completion: nil)
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                        
                    }else{
                        showAlert(msg: response, view: self)
                    }
                    DispatchQueue.main.async {
                        
                    
                }
            }
        }
    }
    
    
    @IBAction func btnSDT(_ sender: Any) {
        let sdt:String = SDTShop ?? "null"

        if #available(iOS 10.0, *) {

           let phonenumber = URL(string:"tel:" + sdt)
            UIApplication.shared.open(phonenumber!)
        } else {
            let url: NSURL = NSURL(string:"tel://" + sdt)!
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func btnSDTN(_ sender: Any) {
         let sdtnn:String = SDTKhach ?? "null"
        if #available(iOS 10.0, *) {
            let phonenumber = URL(string:"tel:" + sdtnn )
            UIApplication.shared.open(phonenumber!)
        } else {
            let url: NSURL = NSURL(string:"tel://" + sdtnn)!
            UIApplication.shared.openURL(url as URL)
        }
    }
//    var order:Order?
//    func runTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ChiTietCongViec.updateTimer)), userInfo: nil, repeats: true)
//    }
//    @objc func updateTimer() {
//        if seconds < 1 {
//            seconds -= 1
//            timerLabel.text = timeString(time: TimeInterval(seconds))
//            timerLabel.textColor = UIColor.red
//        } else {
//            seconds -= 1
//            timerLabel.text = timeString(time: TimeInterval(seconds))
//            timerLabel.textColor = UIColor.blue
//        }
//    }
//    func timeString(time:TimeInterval) -> String {
//        let hours = Int(time) / 3600
//        let minutes = Int(time) / 60 % 60
//        let seconds = Int(time) % 60
//        return String(format:"⏰ %02i:%02i:%02i", hours, minutes, seconds)
//    }

}
