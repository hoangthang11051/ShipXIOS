//
//  history.swift
//  DogApp
//
//  Created by Admin on 7/13/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
class history1: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var tongDon: Int?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historycell1", for: indexPath) as! HistoryCell1
        let des:String = data[indexPath.row].description ?? "null"
        let dis:String = data[indexPath.row].create_time ?? "null"
        let fee:String = data[indexPath.row].fee ?? "null"
        let maDon:String = data[indexPath.row].order_id ?? "null"
        let loaidichvu = data[indexPath.row].service ?? "null"
        let giatrihang = data[indexPath.row].total ?? "null"
        let fullname = data[indexPath.row].fullname ?? "null"
        cell.lblNote.text = "‣ Mô tả: \(des)"
        cell.lblTime.text = "\(dis)"
        cell.lblsoTien.text = "‣ Tiền Ship: "
        cell.lblPhiShip.text = "\(giatrihang)"
        cell.lblMadon.text = "‣ Mã đơn: \(maDon)"
        cell.lblLoaiDichVu.text = "‣ COD: "
        cell.lblThuHo.text = "\(loaidichvu)"
        cell.lblTenshop.text = "\(fullname)"
        cell.lblTienNhanDuoc.text = "‣ Tổng tiền: "
        cell.lblTienthu.text = "\(fee)"
        let test = data.count
        lblTongDon.text = "Tổng đơn: "
        lblDon.text = "\(test)"
        _ = data
        return cell
    }
    
    var order_id = "0"
    var data:[Order] = []
    var mode = 1
    var update = false
    @IBAction func btnNextPage(_ sender: Any) {
        soTrang = soTrang+10
        print(soTrang)
        loadWorking()
    }
    
    @IBAction func btnBackPage(_ sender: Any) {
        if(soTrang == 0){
            loadWorking()
        }else{
            print(soTrang)
            soTrang = soTrang - 10
            print(soTrang)
            loadWorking()
        }
    }
    
    
    func loadWorking(){
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("http://shipx.vn/api/index.php/VinterGetOrders/?hero_id=\(heroID)&status=5&start_date=24-06-2018&end_date=\(DateWorking)&start=\(soTrang)",headers: headers).responseJSON {(response) in
            if(response.error == nil){
                let Value = response.result.value as! NSDictionary
                let Status = Value["status"] as! String
                
                
                if(Status == "success"){
                    
                    let sta = Value["statistical"] as! [String: Any]
                    let total = sta["total"] as! String
                    let total_fee = sta["total_fee"] as! String
                    let total_money = sta["total_money"] as! String
                    print("Test statistical: \(total)")
                    self.lblTongCod.text = "Tổng tiền COD: "
                    self.lblCOD.text = "\(total_money)đ"
                    self.lblTongship.text = "Tổng tiền ship: "
                    self.lblShip.text = "\(total_fee)đ"
                    let res = Value["response"] as! [[String: Any]]
                    self.data.removeAll()
                    for item in res{
                        //
                        print("===========================================")
                        do{
                            let jsonData = try? JSONSerialization.data(withJSONObject: item, options: [])
                            let jsonString:String = String(data: jsonData!, encoding: .utf8)!
                            print("jsonString:",jsonString)
                            let order = try JSONDecoder().decode(Order.self, from: jsonString.data(using: .utf8)!)
                            self.data.append(order)
                        }catch let e{
                            print("error",e)
                        }
                        print(self.data.count)
                        print(self.data)
                        print("===========================================")
                    }
                    //
                    DispatchQueue.main.async {
                        self.tablev.reloadData()
                    }
                }else{
                    let alertController = UIAlertController(title: "Thông Báo", message: "Đã hết!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style:.default) {
                        UIAlertAction in
                        NSLog("OK Pressed")
                        
                    }
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    soTrang = soTrang - 10
                }
            }
        }
    }
    
    @IBOutlet weak var lblTongDon: UILabel!
    @IBOutlet weak var lblTongCod: UILabel!
    @IBOutlet weak var lblTongship: UILabel!
    
    @IBOutlet weak var lblDon: UILabel!
    @IBOutlet weak var lblCOD: UILabel!
    @IBOutlet weak var lblShip: UILabel!
    
    
    
    @IBOutlet weak var tablev: UITableView!
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnLoc(_ sender: Any) {
        let ThongKe = storyboard?.instantiateViewController(withIdentifier: "thongke") as! ThongKe
        self.present(ThongKe, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWorking()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
