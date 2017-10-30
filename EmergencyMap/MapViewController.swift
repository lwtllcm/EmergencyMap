//
//  MapViewController.swift
//  EmergencyMap
//
//  Created by Laurie Wheeler on 10/14/17.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import MapKit

@objc(MapViewController)

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var handle: AuthStateDidChangeListenerHandle?
    
    var test_latitude = 41.15
    var test_longitude = 96.0
    
    fileprivate var _refHandle: DatabaseHandle!
    var ref: DatabaseReference!
    var messages: [DataSnapshot]! = []
    
    //var msglength: NSNumber = 10
   // fileprivate var _refHandle: DatabaseHandle!
    
   // var storageRef: StorageReference!
   // var remoteConfig: RemoteConfig!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("viewDidLoad")
        configureDatabase()
       
       // self.ref.child("messages").child(user.uid).setValue(["userID":"user1"])
        
        
       /*GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        
        handle = Auth.auth().addStateDidChangeListener() { (auth, user) in
            if user != nil {
               // MeasurementHelper.sendLoginEvent()
               // self.performSegue(withIdentifier: Constants.Segues.SignInToFp, sender: nil)
                print("user != nil")
            }
        }
 */
 
    }
    
    deinit {
       
        if let refHandle = _refHandle {
            self.ref.child("messages").removeObserver(withHandle: _refHandle)
        }
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        
        /*
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        let lat1 = CLLocationDegrees(test_latitude)
        let long1 = CLLocationDegrees(test_longitude)
        let coordinate1 = CLLocationCoordinate2D(latitude:test_latitude, longitude: test_longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate1
 */
      //  self.mapView.addAnnotation(ref.child("coordinate") as! MKAnnotation)
        
    }
    
    func configureDatabase() {
        
    
      ref = Database.database().reference()
        // Listen for new messages in the Firebase database
        
        _refHandle = self.ref.child("messages").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.messages.append(snapshot)
            //strongSelf.clientTable.insertRows(at: [IndexPath(row: strongSelf.messages.count-1, section: 0)], with: .automatic)
        })
 
        print("configureDatabase")
        

        let lat1:NSNumber = (CLLocationDegrees(test_latitude) as NSNumber)
        let lat1String:NSString = (NumberFormatter.localizedString(from: lat1, number: .decimal) as NSString)
        print("lat1String", lat1String)
        let long1:NSNumber = (CLLocationDegrees(test_longitude) as NSNumber)
        let long1String:NSString = (NumberFormatter.localizedString(from: long1, number: .decimal) as NSString)
        print("long1String", long1String)
        
       
        print("lat1",lat1)
        print("long1",long1)
        let message = [
            "latitude":lat1String ,
            "longitude":long1String ]
        
        print("message",message)
      
        
        let coordinateItem = ["latitude":lat1String, "longitude":long1String]
        
        let coordintateItemRef = self.ref.child("messages")
        coordintateItemRef.setValue(coordinateItem)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"

        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            pinView?.pinTintColor = UIColor.red
            pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    /*
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue cell
        let cell = self.clientTable.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        // Unpack message from Firebase DataSnapshot
        let messageSnapshot = self.messages[indexPath.row]
        guard let message = messageSnapshot.value as? [String: String] else { return cell }
        let name = message[Constants.MessageFields.name] ?? ""
        let text = message[Constants.MessageFields.text] ?? ""
        cell.textLabel?.text = name + ": " + text
        cell.imageView?.image = UIImage(named: "ic_account_circle")
        if let photoURL = message[Constants.MessageFields.photoURL], let URL = URL(string: photoURL),
            let data = try? Data(contentsOf: URL) {
            cell.imageView?.image = UIImage(data: data)
        }
        return cell
    }
*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/*
    @IBAction func signOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError.localizedDescription)")
        }
    }
   */
    
    
   
}

