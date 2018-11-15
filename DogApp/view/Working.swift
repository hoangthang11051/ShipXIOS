//
//  Working.swift
//  DogApp
//
//  Created by Admin on 7/13/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import MessageUI
import SCLAlertView

class Working: UIViewController ,UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var a: Int = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "workingcell", for: indexPath) as! WorkingCell
        cell.note.text = data[indexPath.row].description
        
        let time = data[indexPath.row].create_time
        cell.time.text = ("\(time!)")
        
        let fullname = data[indexPath.row].fullname
        cell.txtTenShop.text = ("‣ Tên Shop: \(fullname!)")
        let tenKhach = data[indexPath.row].note
        cell.txtNguoiNhan.text = "‣ Tên người nhận: \(tenKhach!)"
        let sdt = data[indexPath.row].phone_number
        if(sdt != nil){
            cell.txtSDT.text = ("‣ Sđt người nhận: \(sdt!)")
        }else{
            let sdt1 = data[indexPath.row].pickup?.mobile!
            cell.txtSDT.text = ("‣ Sđt người nhận: \(sdt1!)")
        }
        
        let diemgiao = data[indexPath.row].dropoff?.address!
        if(diemgiao != nil){
            cell.txtDiemGiao.text = ("‣ Điểm giao: \(diemgiao!)")
        }else{
            let diemgiao1 = data[indexPath.row].pickup?.address!
            cell.txtDiemGiao.text = ("‣ Địa chỉ khách hàng: \(diemgiao1!)")
        }
       a = indexPath.row
        cell.nhanhang.tag = indexPath.row
        cell.btnChitiet.tag = indexPath.row
        
        if(data[indexPath.row].status == "2" && data[indexPath.row].service_id != "3"){
            cell.nhanhang.backgroundColor = UIColor.red
            cell.nhanhang.setTitle("Bắt đầu", for: .normal)
            cell.nhanhang.imageView?.image = UIImage(named: "ic_nhanhang")
            
        }
        if(data[indexPath.row].status == "5" && data[indexPath.row].service_id != "3"){
            cell.nhanhang.backgroundColor = UIColor.green
            cell.nhanhang.imageView?.image = UIImage(named: "ic_done")
//            cell.giaohang.backgroundColor = UIColor.red
//            cell.giaohang.setTitle("Hoàn Thành", for: .normal)
        }
        if(data[indexPath.row].status == "2" && data[indexPath.row].service_id == "3"){
            // Đã nhận
            cell.nhanhang.backgroundColor = UIColor.red
            cell.nhanhang.setTitle("Đã Nhận", for: .normal)
            cell.nhanhang.imageView?.image = UIImage(named: "ic_nhanhang")
            //   print("xin====================chao")
        }
        if(data[indexPath.row].status == "5" && data[indexPath.row].service_id == "3"){
            // Đã nhận
            cell.nhanhang.backgroundColor = UIColor.green
            cell.nhanhang.setTitle("Đã Nhận", for: .normal)
            cell.nhanhang.imageView?.image = UIImage(named: "ic_done")
         //   print("xin====================chao")
        }else{
            cell.nhanhang.addTarget(self, action: #selector(self.nhanhang(_:)), for: .touchUpInside)
        }
       
        return cell
    }
    var so: Int?
    @IBAction func btnChiTiet(_ sender: UIButton) {
        
        let buttonTag = sender.tag
        print(buttonTag)
        so = buttonTag
        ser = data[so!].service_id
        hero = data[so!].hero_id ?? "null"
        order1 = data[so!].order_id ?? "null"
        diemGiao = data[so!].dropoff?.address ?? data[so!].pickup?.address
        tienThuHo = data[so!].money_first ?? "null"
        SDTShop = data[so!].phone_number ?? ""
        SDTKhach = data[so!].pickup?.mobile ?? ""
        tongTien = data[so!].total ?? "null"
        YeuCau = data[so!].note ?? "null"
        latA = data[so!].pickup?.latitude
        lngA = data[so!].pickup?.longitude
        latB = data[so!].dropoff?.latitude
        lngB = data[so!].dropoff?.longitude
        print("DiemGiao",diemGiao)
        let homePage = self.storyboard?.instantiateViewController(withIdentifier: "mainchitiet")
        self.present(homePage!, animated: true, completion: nil)

    }
    func requestLocation(){
        if(Net.isConnectedToNetwork()){
            locationManager.requestAlwaysAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
            }else{
            }
        }else{
            let alertController = UIAlertController(title: "Thông báo", message: "Máy của bạn hiện tại không có kết nối mạng!", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                print("you've pressed ok")
            }
            
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:",error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            if(loadedLocation==false){
                loadedLocation=true
                
                print(location.coordinate)
                lat=location.coordinate.latitude
                lng=location.coordinate.longitude
                print("lat:",lat)
                print("lng:",lng)
                //load weather
                if(update){
                    if(mode == 1){
                        requestNhanHang(hero_id: heroID, order_id: order_id, lat: lat.description, lng: lng.description)
                    }else{
                    }
                    update = false
                }
                
            }else{
                lat=location.coordinate.latitude
                lng=location.coordinate.longitude
                print("lat:",lat)
                print("lng:",lng)
                if(update){
                    if(mode == 1){
                        requestNhanHang(hero_id: heroID, order_id: order_id, lat: lat.description, lng: lng.description)
                    }else{
                     //   requestGiaoHang(hero_id: heroID, order_id: order_id, lat: lat.description, lng: lng.description)
                    }
                    update = false
                }
                
            }
        }
    }
    // If we have been deined access give the user the option to change it
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    // Show the popup to the user if we have been deined access
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Truy cập vị trí đã bị chặn",
                                                message: "Chúng tôi cần bạn đồng ý cung cấp vị trí",
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string:UIApplication.openSettingsURLString) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        alertController.addAction(openAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func nhanhang(_ sender: UIButton){
        mode = 1
        let buttonTag = sender.tag
        print(buttonTag)
        self.a = buttonTag
        order_id = data[buttonTag].order_id!
        print("tag:",data[buttonTag].hero_id!)
        update = true
        requestLocation()
    }

    var order_id = "0"
    var data:[Order] = []
    var lat:Double = 0.0
    var lng:Double = 0.0
    var loadedLocation = false
    var mode = 1
    let locationManager = CLLocationManager()
    var update = false
    var service_id = "0"
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func requestNhanHang(hero_id:String,order_id:String,lat:String,lng:String){
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        let test = "http://shipx.vn/api/index.php/VinterWoking/?hero_id=\(hero_id)&order_id=\(order_id)&lat=\(lat)&long=\(lng)"
        print(test)
        Alamofire.request("http://shipx.vn/api/index.php/VinterWoking/?hero_id=\(hero_id)&order_id=\(order_id)&lat=\(lat)&long=\(lng)",headers: headers).responseJSON {(response) in
            if(response.error == nil){
                let Value = response.result.value as! NSDictionary
            
                let Status = Value["status"] as! String
                let response = Value["response"] as? Any
                print("res",response)
                if(Status == "success"){
                    let alertController = UIAlertController(title: "Thông Báo", message: "Cập nhật trạng thái đơn hàng thành công", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) {
                        UIAlertAction in
                        NSLog("OK Pressed")
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
                    self.loadWorking()
                }
            }
        }
    }
    func requestGiaoHang(hero_id:String,order_id:String,lat:String,lng:String){
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("http://shipx.vn/api/index.php/OrderSuccess/?hero_id=\(hero_id)&order_id=\(order_id)&lat=\(lat)&long=\(lng)",headers: headers).responseJSON {(response) in
            if(response.error == nil){
                let Value = response.result.value as! NSDictionary
                let Status = Value["status"] as! String
                let response = Value["response"] as! String
            
                if(Status == "success"){
                    let alertController = UIAlertController(title: "Thông Báo", message: "Cập Nhật Trạng Thái Đơn Hàng Thành Công!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) {
                        UIAlertAction in
                        NSLog("OK Pressed")
                        self.loadWorking()
                    }
                    alertController.addAction(okAction)
                    
                }else{
                    showAlert(msg: response, view: self)
                }
                DispatchQueue.main.async {
                    
                }
            }
        }
    }
    
    func loadWorking(  ){
        
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("http://shipx.vn/api/index.php/VinterGetWorking/?hero_id=\(heroID)&service=3&status=2&start_date=20-07-2018&end_date=\(DateWorking)&start=0",headers: headers).responseJSON {(response) in
            if(response.error == nil){
                let Value = response.result.value as! NSDictionary
                let Status = Value["status"] as! String
            
            
                if(Status == "success"){
                    let res = Value["response"] as! [[String: Any]]
                    self.data.removeAll()
                    for item in res{
                        print("===========================================")
                        let Service = item["service_id"] as! String
                        
                        do{
                            print(self.service_id)
                            if (Int(Service)! == Int(self.service_id) ){
                            let jsonData = try? JSONSerialization.data(withJSONObject: item, options: [])
                            let jsonString:String = String(data: jsonData!, encoding: .utf8)!
                            print("jsonString:",jsonString)
                            let order = try JSONDecoder().decode(Order.self, from: jsonString.data(using: .utf8)!)
                            self.data.append(order)
                            }
                        }catch let e{
                            print("error",e)
                        }
                        
                        print("===========================================")
                    }
                    //
                    let appearance = SCLAlertView.SCLAppearance(
                        showCloseButton: false
                    )
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                    
                }
            }
        }
    }
    
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWorking()
        loadl()
    }
    func run(after seconds: Int, completion: @escaping () -> Void){
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline){
            completion()
        }
    }
    func loadl(){
        
        run(after: 3){
            self.viewDidLoad()
        }
    }

}
