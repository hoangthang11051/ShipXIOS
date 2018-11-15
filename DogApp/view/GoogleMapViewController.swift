//
//  GoogleMapViewController.swift
//  DogApp
//
//  Created by Admin on 7/4/18.
//  Copyright © 2018 Admin. All rights reserved.
//
import UIKit
import GoogleMaps
import CoreLocation
import Alamofire
import SwiftyJSON
class VacationDestination: NSObject {
    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    
    init(name:String, location: CLLocationCoordinate2D,zoom: Float){
        self.name = name
        self.location = location
        self.zoom = zoom
    }
}

class GoogleMapViewController: UIViewController,CLLocationManagerDelegate, GMSMapViewDelegate,navitimviec {
    func back() {
        let Homepage = self.storyboard?.instantiateViewController(withIdentifier: "homepage")
        self.present(Homepage!, animated: true, completion: nil)
    }
    
    var data:[Order] = []
    
    func getJob(tag:String)->Order?{
        for job in data{
            if tag == job.order_id{
                return job
            }
        }
        return nil
    }
    func getGroupJob(job:Order)-> [Order]{
        var jobs:[Order] = []
        for item in data{
            let lat1:String = (job.pickup?.latitude)!
            let lng1:String = (job.pickup?.longitude)!
            let lat2:String = (item.pickup?.latitude)!
            let lng2:String = (item.pickup?.longitude)!
            if(distance(lat1: Double(lat1)!,lng1: Double(lng1)!,lat2: Double(lat2)!,lng2: Double(lng2)!)<100){
                jobs.append(item)
            }
        }
        return jobs
    }
    
    var Service: String  = " "
    func loadLocation(){
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("http://shipx.vn/api/index.php/VinterGetNewJobs/?hero_id=\(heroID)&service=3",headers: headers).responseJSON {(response) in
            if(response.error == nil){
            let Value = response.result.value as! NSDictionary
            print("value loadlocation:",Value)
           // let Status = Value["status"]
            
            let res = Value["response"] as! [[String: Any]]
            
            for item in res{
                self.Service = item["service_id"] as! String
                if (Int(self.Service)! == 3){
                let Service_id = item["service_id"] as! String
                Order_id = item["order_id"] as! String
                Distance = item["distance"] as! String ?? "null"
                let dropoff = item["dropoff"] as! [String: Any]
                AddressGiao = dropoff["address"]! as! String ?? "null"
                create_time_int = item["create_time_int"]! as! String
                //print("DiemGiao",AddressGiao)
                LatitudeGiao = dropoff["latitude"]! as! String
                // print(LatitudeGiao)
                LongitudeGiao = dropoff["longitude"]! as! String
                //print(LongitudeGiao)
                let pickup = item["pickup"] as! [String: Any]
                 AddressNhan = pickup["address"]! as! String
                print("Diem Nhan: ",AddressNhan)
                print("DiemGiao",AddressGiao)
                 Latitude = pickup["latitude"]! as! String
                print(Latitude)
                Longitude = pickup["longitude"]! as! String
                
                print(Longitude)
                print("===========================================")
                //self.view.addSubview(self.mapView!)
                    let currentLocation = CLLocationCoordinate2D(latitude: Double(Latitude)!, longitude: Double(Longitude)!)
                print(Double(Latitude)!)
                print("currentLocation",currentLocation)
                    let market = GMSMarker()
                
                market.accessibilityValue = Order_id
                market.position = currentLocation
                market.accessibilityLabel = Distance
                market.snippet = AddressGiao
                market.title = Service_id
                market.map = self.mapView
                market.accessibilityHint = create_time_int
                market.icon = UIImage(named: "bike")
                }
                if (Int(self.Service)! == 8){
                    let Service_id = item["service_id"] as! String
                    let pickup = item["pickup"] as! [String: Any]
                    AddressNhan = pickup["address"]! as! String
                    print("Diem Nhan: ",AddressNhan)
                    Latitude = pickup["latitude"]! as! String
                    print(Latitude)
                    Order_id = item["order_id"] as! String
                    Longitude = pickup["longitude"]! as! String
                    print(Longitude)
                    print("=============================")
                    Description = item["description"] as! String
                    Note = item["note"] as! String
                    let suadodien = GMSMarker()
                    suadodien.icon = UIImage(named: "idea")
                    let currentLocation1 = CLLocationCoordinate2D(latitude: Double(Latitude)!, longitude: Double(Longitude)!)
                    suadodien.accessibilityValue = Order_id
                    suadodien.position = currentLocation1
                    suadodien.map = self.mapView
                    suadodien.snippet = AddressGiao
                    suadodien.title = Service_id
                    suadodien.accessibilityHint = Description
                }
                if (Int(self.Service)! == 5){
                    let Service_id = item["service_id"] as! String
                    let pickup = item["pickup"] as! [String: Any]
                    AddressNhan = pickup["address"]! as! String
                    print("Diem Nhan: ",AddressNhan)
                    Latitude = pickup["latitude"]! as! String
                    print(Latitude)
                    Order_id = item["order_id"] as! String
                    Longitude = pickup["longitude"]! as! String
                    print(Longitude)
                    print("=============================")
                    Description = item["description"] as! String
                    Note = item["note"] as! String
                    let donnha = GMSMarker()
                    donnha.icon = UIImage(named: "cleaner")
                    let currentLocation1 = CLLocationCoordinate2D(latitude: Double(Latitude)!, longitude: Double(Longitude)!)
                    donnha.accessibilityValue = Order_id
                    donnha.position = currentLocation1
                    donnha.map = self.mapView
                    donnha.snippet = AddressGiao
                    donnha.title = Service_id
                    donnha.accessibilityHint = Description
                }
                if (Int(self.Service)! == 6){
                    let Service_id = item["service_id"] as! String
                    let pickup = item["pickup"] as! [String: Any]
                    AddressNhan = pickup["address"]! as! String
                    print("Diem Nhan: ",AddressNhan)
                    Latitude = pickup["latitude"]! as! String
                    print(Latitude)
                    Order_id = item["order_id"] as! String
                    Longitude = pickup["longitude"]! as! String
                    print(Longitude)
                    print("=============================")
                    Description = item["description"] as! String
                    Note = item["note"] as! String
                    let dientu = GMSMarker()
                    dientu.icon = UIImage(named: "robot")
                    let currentLocation1 = CLLocationCoordinate2D(latitude: Double(Latitude)!, longitude: Double(Longitude)!)
                    dientu.accessibilityValue = Order_id
                    dientu.position = currentLocation1
                    dientu.map = self.mapView
                    dientu.snippet = AddressGiao
                    dientu.title = Service_id
                    dientu.accessibilityHint = Description
                }
                if (Int(self.Service)! == 7){
                    let Service_id = item["service_id"] as! String
                    let pickup = item["pickup"] as! [String: Any]
                    AddressNhan = pickup["address"]! as! String
                    print("Diem Nhan: ",AddressNhan)
                    Latitude = pickup["latitude"]! as! String
                    print(Latitude)
                    Order_id = item["order_id"] as! String
                    Longitude = pickup["longitude"]! as! String
                    print(Longitude)
                    print("=============================")
                    Description = item["description"] as! String
                    Note = item["note"] as! String
                    let nail = GMSMarker()
                    nail.icon = UIImage(named: "nail-polish")
                    let currentLocation1 = CLLocationCoordinate2D(latitude: Double(Latitude)!, longitude: Double(Longitude)!)
                    nail.accessibilityValue = Order_id
                    nail.position = currentLocation1
                    nail.map = self.mapView
                    nail.snippet = AddressGiao
                    nail.title = Service_id
                    nail.accessibilityHint = Description
                }
                if (Int(self.Service)! == 9){
                    let Service_id = item["service_id"] as! String
                    let pickup = item["pickup"] as! [String: Any]
                    AddressNhan = pickup["address"]! as! String
                    print("Diem Nhan: ",AddressNhan)
                    Latitude = pickup["latitude"]! as! String
                    print(Latitude)
                    Order_id = item["order_id"] as! String
                    Longitude = pickup["longitude"]! as! String
                    print(Longitude)
                    print("=============================")
                    Description = item["description"] as! String
                    Note = item["note"] as! String
                    let cuuhoxe = GMSMarker()
                    cuuhoxe.icon = UIImage(named: "toolbox")
                    let currentLocation1 = CLLocationCoordinate2D(latitude: Double(Latitude)!, longitude: Double(Longitude)!)
                    cuuhoxe.accessibilityValue = Order_id
                    cuuhoxe.position = currentLocation1
                    cuuhoxe.map = self.mapView
                    cuuhoxe.snippet = AddressGiao
                    cuuhoxe.title = Service_id
                    cuuhoxe.accessibilityHint = Description
                }
                if (Int(self.Service)! == 10){
                    let Service_id = item["service_id"] as! String
                    let pickup = item["pickup"] as! [String: Any]
                    AddressNhan = pickup["address"]! as! String
                    print("Diem Nhan: ",AddressNhan)
                    Latitude = pickup["latitude"]! as! String
                    print(Latitude)
                    Order_id = item["order_id"] as! String
                    Longitude = pickup["longitude"]! as! String
                    print(Longitude)
                    print("=============================")
                    Description = item["description"] as! String
                    Note = item["note"] as! String
                    let cuuhopc = GMSMarker()
                    cuuhopc.icon = UIImage(named: "software")
                    let currentLocation1 = CLLocationCoordinate2D(latitude: Double(Latitude)!, longitude: Double(Longitude)!)
                    cuuhopc.accessibilityValue = Order_id
                    cuuhopc.position = currentLocation1
                    cuuhopc.map = self.mapView
                    cuuhopc.snippet = AddressGiao
                    cuuhopc.title = Service_id
                    cuuhopc.accessibilityHint = Description
                }
                if (Int(self.Service)! == 2){
                    let Service_id = item["service_id"] as! String
                    let pickup = item["pickup"] as! [String: Any]
                    AddressNhan = pickup["address"]! as! String
                    print("Diem Nhan: ",AddressNhan)
                    Latitude = pickup["latitude"]! as! String
                    print(Latitude)
                    Order_id = item["order_id"] as! String
                    Longitude = pickup["longitude"]! as! String
                    print(Longitude)
                    print("=============================")
                    Description = item["description"] as! String
                    Note = item["note"] as! String
                    let taxitai = GMSMarker()
                    taxitai.icon = UIImage(named: "taxitai")
                    let currentLocation1 = CLLocationCoordinate2D(latitude: Double(Latitude)!, longitude: Double(Longitude)!)
                    taxitai.accessibilityValue = Order_id
                    taxitai.position = currentLocation1
                    taxitai.map = self.mapView
                    taxitai.snippet = AddressGiao
                    taxitai.title = Service_id
                    taxitai.accessibilityHint = Description
                }
                do{
                    let jsonData = try? JSONSerialization.data(withJSONObject: item, options: [])
                    let jsonString:String = String(data: jsonData!, encoding: .utf8)!
                    print("jsonString:",jsonString)
                    let order = try JSONDecoder().decode(Order.self, from: jsonString.data(using: .utf8)!)
                    self.data.append(order)
                }catch let e{
                    print("error",e)
                }
                }

            
            }
        }
    }
    
    
    
    let locationManager = CLLocationManager()
    
    var mapView:GMSMapView?
    var currentDestination: VacationDestination?

    
    let a:CLLocationManager = CLLocationManager()
    
    func run(after seconds: Int, completion: @escaping () -> Void){
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline){
            completion()
        }
        
    }
////    func back1(){
////        let bando = storyboard?.instantiateViewController(withIdentifier: "googlemap") as! BanDoCongViec
////        self.present(bando, animated: true, completion: nil)
////    }
//    func loadl(){
//
//        run(after: 30){
//            self.loadLocation()
//            self.viewDidLoad()
//            self.addSub()
//            self.loadView()
//
//        }
//    }
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        loadLocation()
       
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("******************************************************************")
     //   KhoangCach = marker.accessibilityLabel!
        DiemNhan = marker.title!
        DiemGiao = marker.snippet!
        MaDon = marker.accessibilityValue!
        thoiGiancon = marker.accessibilityHint!
        print(DiemNhan)
        print(DiemGiao)
        if (Int(DiemNhan)! == 3 ){
        let jobView = self.storyboard?.instantiateViewController(withIdentifier: "jobview") as! JobViewController
        
        jobView.data = getGroupJob(job: getJob(tag: marker.accessibilityValue!)!)
        
        self.present(jobView, animated: true, completion: nil)
        }else{
            
        let jobView2 = self.storyboard?.instantiateViewController(withIdentifier: "job2view") as! Job2ViewController
        
        jobView2.data = getGroupJob(job: getJob(tag: marker.accessibilityValue!)!)
        
        self.present(jobView2, animated: true, completion: nil)}
        return true
    }
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 21.5961536, longitude: 105.8121259  , zoom: 11.3759)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        mapView?.delegate = self
        mapView?.isMyLocationEnabled = true
//        let market = GMSMarker()
//        market.position = CLLocationCoordinate2D(latitude: 21, longitude: 105)
//        market.title = "hihi"
//        market.snippet = "hehe"
//        market.map = mapView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addSub()
    }
    
    func addSub(){
        let chucNangTren = storyboard!.instantiateViewController(withIdentifier: "navitimviec") as? NaviTimViec
        chucNangTren?.dele = self
        self.addChild(chucNangTren!)
        var fra:CGRect
        if(self.view.frame.height>800){
            fra = CGRect(x: 0, y: 20, width: self.view.frame.width, height: 50)
        }else{
            fra = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        }
        
        chucNangTren?.view.frame = fra// or better, turn off `translatesAutoresizingMaskIntoConstraints` and then define constraints for this subview
        self.view.addSubview((chucNangTren?.view)!)
        chucNangTren?.didMove(toParent: self)
        //duoi
    }
    
    }



protocol navitimviec {
    func back()
}
