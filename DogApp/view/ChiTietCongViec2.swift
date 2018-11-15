//
//  ChiTietCongViec2.swift
//  DogApp
//
//  Created by Thắng Nguyễn Hoàng on 7/30/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
class ChiTietCongViec2: UIViewController {
    var order:Order?
    
    @IBOutlet weak var lblDiemDen: UILabel!
    @IBOutlet weak var lblMaDon: UILabel!
    @IBOutlet weak var lblLoaiDichVu: UILabel!
    @IBOutlet weak var lblSdt: UILabel!
    @IBOutlet weak var lblMoTa: UILabel!
    @IBOutlet weak var lblGhiChu: UILabel!
    @IBOutlet weak var btnsdt: UIButton!
    
    @IBAction func btnBanDo(_ sender: Any) {
        let bando = storyboard?.instantiateViewController(withIdentifier: "bando") as! BanDoCongViec
        bando.order = self.order
        self.present(bando, animated: true, completion: nil)
    }
    
    
    @IBAction func btnSDTN(_ sender: Any) {
        let sdtnn:String = (order?.pickup?.mobile ?? "Trống")!
        if #available(iOS 10.0, *) {
            let phonenumber = URL(string:"tel:" + sdtnn )
            UIApplication.shared.open(phonenumber!)
        } else {
            let url: NSURL = NSURL(string:"tel://" + sdtnn)!
            UIApplication.shared.openURL(url as URL)
        }
    }
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dn:String = (order?.pickup?.address!)!
        lblDiemDen.text = "Điểm Đến: \(dn)"
        let md:String = (order?.order_id!)!
        lblMaDon.text = "Mã Đơn \(md)"
        let ldv:String = (order?.service!)!
        lblLoaiDichVu.text = "Loại Dịch Vụ: \(ldv)"
        let sdt:String = (order?.pickup?.mobile)!
        lblSdt.text = "Số Điện Thoại: "
        btnsdt.setTitle("\(sdt)", for: .normal)
        let mt:String = (order?.description)!
        lblMoTa.text = "Tên khách hàng: \(mt)"
        let gc:String = (order?.note)!
        lblGhiChu.text = "Ghi chú: \(gc)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func btnThanhCong(_ sender: Any) {
        var hero = order?.hero_id
        var order1 = order?.order_id
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
                    let alertController = UIAlertController(title: "Thông Báo", message: "Cập nhập trạng thái thành công!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) {
                        UIAlertAction in
                        NSLog("OK Pressed")
                        let jobTable = self.storyboard?.instantiateViewController(withIdentifier: "jobworking")
                        self.present(jobTable!, animated: true, completion: nil)
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
}
