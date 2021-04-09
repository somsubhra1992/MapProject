//
//  GeoFencingViewController.swift
//  MapProject
//
//  Created by Somsubhra Dasgupta on 09/04/21.
//  Copyright © 2021 Somsubhra. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class GeoFencingViewController: UIViewController {

    var locationManager = CLLocationManager()
    var locationsToMonitor : [MapLocation]!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.desiredAccuracy = .greatestFiniteMagnitude
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        mapView.showsUserLocation = true
                
        readLocationToMonitor()
        updateMonitorLocations()
    }
    
    func readLocationToMonitor()
    {
        if let filePath = Bundle.main.path(forResource: "LocationToMonitor", ofType: "plist")
        {
            let locationsArray = NSMutableArray.init(contentsOfFile: filePath)
            let decoder = JSONDecoder()
            
            guard let data = try? JSONSerialization.data(withJSONObject: locationsArray, options: []) else {
                return
            }
            
            guard let savedLocations = try? decoder.decode([MapLocation].self, from: data) as [MapLocation] else {
               return
            }
            
            locationsToMonitor = savedLocations
            
        }
    }
    
    func updateMonitorLocations()
    {
        for location in locationsToMonitor
        {
            locationManager.startMonitoring(for: location.region)
            mapView.addAnnotation(location)
            mapView.addOverlay(MKCircle(center: location.coordinate, radius: location.radius))
            
            if !locationManager.monitoredRegions.contains(location.region)
            {
                
            }
        }
        
        if let coordinate = locationsToMonitor.first?.coordinate
        {
            let region = MKCoordinateRegion.init(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 1000)
            self.mapView.setRegion(region, animated: true)
        }
        
        locationManager.startUpdatingLocation()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func stopMonitoring(_ sender: Any)
    {
        locationManager.monitoredRegions.forEach({locationManager.stopMonitoring(for: $0)})
    }
}

extension GeoFencingViewController : CLLocationManagerDelegate
{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse
        {
            if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self)
            {
                self.updateMonitorLocations()
            }
            
        }
    }
    
    //notifies when user entries a region
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Entered \(region.identifier)")
        CoreDatamanager.shared.addActivityDetails(using: region.identifier, event_time: Date(), event_type: "Entered")
    }
    
    //notifies when user exit a region
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exited \(region.identifier)")
        CoreDatamanager.shared.addActivityDetails(using: region.identifier, event_time: Date(), event_type: "Exited")
    }
    
    //any error while getting the location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    //any error while getting the region
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("monitoringDidFail")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first
        {
            print(location)
        }
        
    }
    
}

extension GeoFencingViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    let identifier = "myGeotification"
    if annotation is MapLocation {
      var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
      if annotationView == nil {
        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView?.canShowCallout = true
      } else {
        annotationView?.annotation = annotation
      }
      return annotationView
    }
    return nil
  }

  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    if overlay is MKCircle {
      let circleRenderer = MKCircleRenderer(overlay: overlay)
      circleRenderer.lineWidth = 1.0
      circleRenderer.strokeColor = .purple
      circleRenderer.fillColor = UIColor.purple.withAlphaComponent(0.4)
      return circleRenderer
    }
    return MKOverlayRenderer(overlay: overlay)
  }

}
