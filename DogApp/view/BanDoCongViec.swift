//
//  BanDoCongViec.swift
//  DogApp
//
//  Created by Admin on 7/13/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON

class BanDoCongViec: UIViewController,
CLLocationManagerDelegate,
GMSMapViewDelegate,
navi{
    

    func back() {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 500
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if (status == CLAuthorizationStatus.authorizedWhenInUse)
            
        {
            mapView?.isMyLocationEnabled = true
        }
    }
    var lat3a:Double = 0.0
    var lng3a:Double = 0.0
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last
        mapView?.camera = GMSCameraPosition.camera(withTarget: newLocation!.coordinate, zoom: 15.0)
        mapView?.settings.myLocationButton = true
        self.view = self.mapView
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2DMake(newLocation!.coordinate.latitude, newLocation!.coordinate.longitude)
        print("lat: ",newLocation!.coordinate.latitude)
        print("long:* ",newLocation!.coordinate.longitude)
        lat3a = newLocation!.coordinate.latitude
        lng3a = newLocation!.coordinate.longitude
//        marker.map = self.mapView
//        marker.icon = UIImage(named: "")
        
//        let market2 = GMSMarker()
//        market2.position = CLLocationCoordinate2D(latitude: Double(lat2)!, longitude: Double(lng2)!)
//        market2.title = order?.dropoff?.address
//        market2.icon = UIImage(named: "end_green")
//        market2.map = mapView
    }

    override func viewDidAppear(_ animated: Bool) {
        
        locationManager
        loadView()
        addSub()
    }
    
    func addSub(){
        let chucNangTren = storyboard!.instantiateViewController(withIdentifier: "navibando") as? NaviBanDo
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

    let locationManager = CLLocationManager()
    
    var mapView:GMSMapView?
    let a:CLLocationManager = CLLocationManager()
    var order:Order?
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("******************************************************************")
//        KhoangCach = marker.accessibilityLabel!
//        DiemNhan = marker.title!
//        DiemGiao = marker.snippet!
//        print(DiemNhan)
//        print(DiemGiao)
//        let jobView = self.storyboard?.instantiateViewController(withIdentifier: "jobview")
//        self.present(jobView!, animated: true, completion: nil)
        return true
    }
    
    override func loadView() {
        //addSub()
        var lat3:Double = 0.0
        var lng3:Double = 0.0
        mapView?.delegate = self
        let market = GMSMarker()
        let lat1:String = latA ?? "null"
        let lng1:String = lngA ?? "null"
        //let a = (order?.service_id)!
        var lat2:String = " "
        var lng2:String = " "
        if(ser == "3" ){
            lat2 = latB ?? "null"
            lng2 = lngA ?? "null"
        }else{
            lat3 = lat3a
            lng3 = lng3a
        }
        print("lat1",lat1)
        print("lng1",lng1)
//        print("lat2",lat2)
//        print("lng2",lng2)
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(lat1)!, longitude: Double(lng1)!  , zoom: 11)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView?.isMyLocationEnabled = true
        mapView?.settings.myLocationButton = true
        view = mapView
        if(ser == "3" ){
        drawPath(origin: "\(lat1),\(lng1)", destination: "\(lat2),\(lng2)")
            print("lat2: ",lat2)
            print("lng2: ",lng2)
        }else{
            drawPath(origin: "\(lat1),\(lng1)", destination: "\(lat3),\(lng3)")
            print("lat3: ",lat3)
            print("lng3: ",lng3)
        }
        market.position = CLLocationCoordinate2D(latitude: Double(lat1)!, longitude: Double(lng1)!)
        market.title = diemGiao
        market.icon = UIImage(named: "start_blue")
        market.map = mapView
        let market2 = GMSMarker()
        if(ser == "3" ){
        market2.position = CLLocationCoordinate2D(latitude: Double(lat2)!, longitude: Double(lng2)!)
            //market2.title = diemGiao
            market2.icon = UIImage(named: "end_green")
            market2.map = mapView
        }
        if(ser != "3" ){
            print("hello basjflsflknfjffsjkfl")
            market2.position = CLLocationCoordinate2D(latitude:lat3, longitude: lng3)
           // market2.title = order?.dropoff?.address
            market2.icon = UIImage(named: "end_green")
            market2.map = mapView
        }
        
        

    }
    
    func drawPath(origin:String,destination:String){
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        print("url:",url)
        Alamofire.request(url).responseJSON{ response in
            print(response.request as Any)
            print(response.response as Any)
            print(response.data as Any)
            print(response.result as Any)
            do{
                let json = try JSON(data: response.data!)
                let routes = json["routes"].arrayValue
                
                for route in routes{
                    let routeOverviewPolyline = route["overview_polyline"].dictionary
                    let points = routeOverviewPolyline!["points"]?.stringValue
                    let path = GMSPath.init(fromEncodedPath: points!)
                    let polyline = GMSPolyline.init(path: path)
                    polyline.strokeWidth = 4
                    polyline.strokeColor = UIColor.red
                    polyline.map = self.mapView
                }
            }catch let e{
                print("error:",e)
            }
            
            
        }
    }
}

protocol navi {
    func back()
}
