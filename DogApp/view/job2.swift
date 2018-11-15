//
//  job2.swift
//  DogApp
//
//  Created by Admin on 7/13/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
class job2: UIViewController {

    @IBOutlet weak var lbljob: UILabel!
    
    @IBOutlet weak var viewGiaoHangNhanh: UIView!
    @IBOutlet weak var viewDonNha: UIView!
    @IBOutlet weak var viewSuaChuaDienTu: UIView!
    @IBOutlet weak var viewLamDepTaiNha: UIView!
    @IBOutlet weak var viewSuaChuaDienNuoc: UIView!
    @IBOutlet weak var viewCuuHoXeMay: UIView!
    @IBOutlet weak var viewCuuHoMayTinh: UIView!
    @IBOutlet weak var viewTaxiTai: UIView!
    @IBOutlet weak var viewXeChung: UIView!
    

    func load(){
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("http://shipx.vn/api/index.php/VinterGetWorking/?hero_id=\(heroID)",headers: headers).responseJSON {(response) in
            if(response.error == nil){
            let Value = response.result.value as! NSDictionary
                print("vintergetNewJob: \(Value)")
            let Status = Value["status"] as! String
                if(Status == "success"){
                    let res = Value["response"] as! [[String: Any]]
                    for item in res{
                        let Service = item["service_id"] as! String
                        let Service_id = Int(Service)!
                        if (Service_id == 3 ){
                            self.viewGiaoHangNhanh?.isHidden = false
                        }
                        if (Service_id == 5 ){
                            self.viewDonNha?.isHidden = false
                        }
                        if (Service_id == 6 ){
                            self.viewSuaChuaDienTu?.isHidden = false
                            
                        }
                        if (Service_id == 7 ){
                            self.viewLamDepTaiNha?.isHidden = false
                            
                        }
                        if (Service_id == 8 ){
                            self.viewSuaChuaDienNuoc?.isHidden = false
                            
                        }
                        if (Service_id == 9 ){
                            self.viewCuuHoXeMay?.isHidden = false
                            
                        }
                        if (Service_id == 10 ){
                            self.viewCuuHoMayTinh?.isHidden = false
                            
                        }
                        if (Service_id == 2 ){
                            self.viewTaxiTai?.isHidden = false
                            
                        }
                        
                    }
                }
            }
            
        }
        
            
        }
    
    @IBAction func btnBack(_ sender: Any) {
        
        let jobTable = self.storyboard?.instantiateViewController(withIdentifier: "homepage")
        self.present(jobTable!, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setOnClickListener()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        load()
    }
    func setOnClickListener(){
        viewGiaoHangNhanh.isUserInteractionEnabled = true
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(giaohangnhanh(tapGestureRecognizer:)))
        viewGiaoHangNhanh.addGestureRecognizer(tap1)
        
        viewDonNha.isUserInteractionEnabled = true
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(donnha(tapGestureRecognizer:)))
        viewDonNha.addGestureRecognizer(tap2)
        
        viewSuaChuaDienTu.isUserInteractionEnabled = true
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(dientu(tapGestureRecognizer:)))
        viewSuaChuaDienTu.addGestureRecognizer(tap3)
        
        viewLamDepTaiNha.isUserInteractionEnabled = true
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(lamdep(tapGestureRecognizer:)))
        viewLamDepTaiNha.addGestureRecognizer(tap4)
        
        viewSuaChuaDienNuoc.isUserInteractionEnabled = true
        let tap9 = UITapGestureRecognizer(target: self, action: #selector(diennuoc(tapGestureRecognizer:)))
        viewSuaChuaDienNuoc.addGestureRecognizer(tap9)
        
        viewCuuHoXeMay.isUserInteractionEnabled = true
        let tap6 = UITapGestureRecognizer(target: self, action: #selector(cuuhoxe(tapGestureRecognizer:)))
        viewCuuHoXeMay.addGestureRecognizer(tap6)
        
        viewCuuHoMayTinh.isUserInteractionEnabled = true
        let tap7 = UITapGestureRecognizer(target: self, action: #selector(cuhopc(tapGestureRecognizer:)))
        viewCuuHoMayTinh.addGestureRecognizer(tap7)
        
        viewTaxiTai.isUserInteractionEnabled = true
        let tap8 = UITapGestureRecognizer(target: self, action: #selector(taxitai(tapGestureRecognizer:)))
        viewTaxiTai.addGestureRecognizer(tap8)
    }
    
    @objc func giaohangnhanh(tapGestureRecognizer: UITapGestureRecognizer){
        let jobTable = self.storyboard?.instantiateViewController(withIdentifier: "jobtable2") as! Working
        jobTable.service_id = "3"
        self.present(jobTable, animated: true, completion: nil)
        print("3")
    }
    @objc func donnha(tapGestureRecognizer: UITapGestureRecognizer){
        let jobTable = self.storyboard?.instantiateViewController(withIdentifier: "jobtable2") as! Working
        jobTable.service_id = "5"
        self.present(jobTable, animated: true, completion: nil)
    }
    @objc func dientu(tapGestureRecognizer: UITapGestureRecognizer){
        let jobTable = self.storyboard?.instantiateViewController(withIdentifier: "jobtable2") as! Working
        jobTable.service_id = "6"
        self.present(jobTable, animated: true, completion: nil)
    }
    @objc func lamdep(tapGestureRecognizer: UITapGestureRecognizer){
        let jobTable = self.storyboard?.instantiateViewController(withIdentifier: "jobtable2") as! Working
        jobTable.service_id = "7"
        self.present(jobTable, animated: true, completion: nil)
    }
    @objc func diennuoc(tapGestureRecognizer: UITapGestureRecognizer){
        let jobTable = self.storyboard?.instantiateViewController(withIdentifier: "jobtable2") as! Working
        jobTable.service_id = "8"
        self.present(jobTable, animated: true, completion: nil)
        print("8")
    }
    @objc func cuuhoxe(tapGestureRecognizer: UITapGestureRecognizer){
        let jobTable = self.storyboard?.instantiateViewController(withIdentifier: "jobtable2") as! Working
        jobTable.service_id = "9"
        self.present(jobTable, animated: true, completion: nil)
    }
    @objc func cuhopc(tapGestureRecognizer: UITapGestureRecognizer){
        let jobTable = self.storyboard?.instantiateViewController(withIdentifier: "jobtable2") as! Working
        jobTable.service_id = "10"
        self.present(jobTable, animated: true, completion: nil)
    }
    @objc func taxitai(tapGestureRecognizer: UITapGestureRecognizer){
        let jobTable = self.storyboard?.instantiateViewController(withIdentifier: "jobtable2") as! Working
        jobTable.service_id = "2"
        self.present(jobTable, animated: true, completion: nil)
    }
    
}
