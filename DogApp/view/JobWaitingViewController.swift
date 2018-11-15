//
//  JobWaitingViewController.swift
//  DogApp
//
//  Created by Admin on 7/8/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire

class JobWaitingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var YeuCau = [String]()
    var Thoigian = [String]()
    var soCV: Int = 0
    @IBOutlet weak var tableview: UITableView!
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("http://shipx.vn/api/index.php/VinterGetOrders/?hero_id=\(heroID)&status=9&start_date=21-06-2018&end_date=\(DateWorking)&start=0",headers: headers).responseJSON {(response) in
            if(response.error == nil){
                let Value = response.result.value as! NSDictionary
                let Status = Value["status"] as! String
                if(Status == "success"){
                    let res = Value["response"] as! [[String: Any]]
                    self.soCV = res.count
                    print(self.soCV)
                    for item in res{
                        self.YeuCau.append(item["description"] as! String)
                        self.Thoigian.append(item["create_time"] as! String)
                        print(self.YeuCau)
                        
                        print(self.Thoigian)
                        print("===========================================")
                    }
                    //
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        print(soCV)
        return soCV
    }

    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! JobWaitingCell
        cell.lblThoigian.text = Thoigian[indexPath.row]
        cell.lblYeucau.text = YeuCau[indexPath.row]
        return cell
    }
    
    
}
