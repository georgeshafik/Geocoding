//
//  ForwardGeocodingViewController.swift
//  Geocoding
//
//  Created by George Shafik on 13/7/19.
//  Copyright © 2019 George Shafik. All rights reserved.
//

import UIKit
import CoreLocation

class ForwardGeocodingViewController: UIViewController {

  // MARK: - Properties
  
  @IBOutlet weak var countryTextField: UITextField!
  @IBOutlet weak var streetTextField: UITextField!
  @IBOutlet weak var cityTextField: UITextField!
  
  @IBOutlet weak var geocodeButton: UIButton!
  @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
  
  @IBOutlet weak var locationLabel: UILabel!
  
  lazy var geocoder = CLGeocoder()
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    countryTextField.delegate = self
    streetTextField.delegate = self
    cityTextField.delegate = self    
  }

  // MARK: - Custom Functions
  
  private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
    // Update View
    geocodeButton.isHidden = false
    activityIndicatorView.stopAnimating()
    
    if let error = error {
      print("Unable to Forward Geocode Address (\(error))")
      locationLabel.text = "Unable to Find Location for Address"
      
    } else {
      var location: CLLocation?
      
      if let placemarks = placemarks, placemarks.count > 0 {
        location = placemarks.first?.location
      }
      
      if let location = location {
        let coordinate = location.coordinate
        locationLabel.text = "\(coordinate.latitude), \(coordinate.longitude)"
      } else {
        locationLabel.text = "No Matching Location Found"
      }
    }
    
  }

  // MARK: - Actions
  
  @IBAction func geocode(_ sender: UIButton) {
    guard let country = countryTextField.text else { return }
    guard let street = streetTextField.text else { return }
    guard let city = cityTextField.text else { return }
    
    //print("\(country), \(city), \(street)")

    // Create Address String
    let address = "\(country), \(city), \(street)"
    
    // Geocode Address String
    geocoder.geocodeAddressString(address) { (placemarks, error) in
      // Process Response
      self.processResponse(withPlacemarks: placemarks, error: error)
    }
    
    // Update View
    geocodeButton.isHidden = true
    activityIndicatorView.startAnimating()
    
    hideKeybord()
    
  }
 

  
}


