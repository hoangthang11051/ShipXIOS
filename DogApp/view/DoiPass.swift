//
//  DoiPass.swift
//  DogApp
//
//  Created by Thắng Nguyễn Hoàng on 8/2/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
class DoiPass: UIViewController {

    @IBOutlet weak var txtMKCu: UITextField!
    @IBOutlet weak var txtMKMoi: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    func showAlert1(msg:String,view:UIViewController){
        let alertController = UIAlertController(title: "Thông Báo", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {
            UIAlertAction in
            NSLog("OK Pressed")
            let view = self.storyboard?.instantiateViewController(withIdentifier: "view")
            self.present(view!, animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        view.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnDoiPass(_ sender: Any) {
        let mkcu = txtMKCu.text!
        let mkmoi = txtMKMoi.text!
        //http://shipx.vn/api/index.php/VinterChangePassword/?hero_id=387&old_password=123456&new_password=1234567
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("http://shipx.vn/api/index.php/VinterChangePassword/?hero_id=\(heroID)&old_password=\(mkcu)&new_password=\(mkmoi)",headers: headers).responseJSON {(response) in
            if(response.error == nil){
                let Value = response.result.value as! NSDictionary
                let Status = Value["status"] as! String
                let response = Value["response"] as! String
                if(Status == "success"){
                    self.showAlert1(msg: response, view: self)
                }
                if(Status == "error"){
                    self.showAlert1(msg: response, view: self)
                }
            }
        }
        
  }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
