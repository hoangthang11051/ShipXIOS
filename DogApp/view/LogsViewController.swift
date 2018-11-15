//
//  LogsViewController.swift
//  DogApp
//
//  Created by Admin on 11/12/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
class LogsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Logs", for: indexPath) as! LogsTableViewCell
        let staff_id = data[indexPath.row].staff_id ?? "0"
        let hero_id = data[indexPath.row].hero_id ?? "0"
        let action = data[indexPath.row].action
        let timemi = data[indexPath.row].created_time
        
        var tacnhan:String?
        let time:String?
        var TrangThai:String?
        
        time = timemi
        
        if(staff_id == "0"){
            tacnhan = "Shiper";
        }
        if(hero_id == "0"){
            tacnhan = "Quản trị viên"
        }
        if(action == "2"){
            TrangThai = "nhận đơn"
        }
        if(action == "3"){
            TrangThai = "hủy đơn"
        }
        if(action == "4"){
            TrangThai = "hủy đơn"
        }
        if(action == "5"){
            TrangThai = "hủy đơn"
        }
        if(action == "6"){
            TrangThai = "hủy đơn"
        }
        if(action == "7"){
            TrangThai = "hủy đơn"
        }
        if(action == "8"){
            TrangThai = "hủy đơn"
        }
        let a:Int = Int(timemi!)!
        
        let date = Date(timeIntervalSince1970: (TimeInterval(a)))
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "🕔 dd-MM HH:mm"
        
        cell.lblLogs.text = "\(dateFormatter.string(from: date)): \(tacnhan!) đã \(TrangThai!)"
        return cell
    }
//        func timeString(time:TimeInterval) -> String {
//            let hours = Int(time) / 3600
//            let minutes = Int(time) / 60 % 60
//            let seconds = Int(time) % 60
//            return String(format:"⏰ %02i:%02i:%02i", hours, minutes, seconds)
//        }

    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        loadWorking()
    }
    var data:[Logs] = []
    func loadWorking(){
        //print("https://shipx.vn/api/index.php/Report/getLogs/?hero_id=\(heroID)&order_id=\(Order_id)")
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("https://shipx.vn/api/index.php/Report/getLogs/?hero_id=\(heroID)&order_id=\(order1!)",headers: headers).responseJSON {(response) in
            if(response.error == nil){
                let Value = response.result.value as! NSDictionary
                let Status = Value["status"] as! String
                let res = Value["mesage"] as! [[String: Any]]
                
                if(Status == "success"){
                    for item in res{
                        //
                        print("===========================================")
                        do{
                            let jsonData = try? JSONSerialization.data(withJSONObject: item, options: [])
                            let jsonString:String = String(data: jsonData!, encoding: .utf8)!
                            print("jsonString:",jsonString)
                            let order = try JSONDecoder().decode(Logs.self, from: jsonString.data(using: .utf8)!)
                            self.data.append(order)
                        }catch let e{
                            print("error",e)
                        }
                        print(self.data.count)
                        print("Logs: \(self.data)")
                        print("===========================================")
                    }
                    //
                    DispatchQueue.main.async {
                        self.table.reloadData()
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

}
