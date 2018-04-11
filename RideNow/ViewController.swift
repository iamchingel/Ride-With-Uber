//
//  ViewController.swift
//  RideNow
//
//  Created by Sanket Ray on 25/10/17.
//  Copyright © 2017 Sanket Ray. All rights reserved.
//

import UIKit
import UberRides
import CoreLocation


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = RideRequestButton()
        view.addSubview(button)
        
        button.center = view.center
        let ridesClient = RidesClient()
        let dropOffLocation = CLLocation(latitude: 20.301647, longitude: 85.819135)
        let pickUpLocation = CLLocation(latitude : 20.323706, longitude: 85.814981)
        let builder = RideParametersBuilder()
        builder.pickupLocation = pickUpLocation
        builder.pickupNickname = "Home"
        builder.dropoffLocation = dropOffLocation
        builder.dropoffNickname = "Mayfair Lagoon, Bhubaneswar"

        var productID = ""
        ridesClient.fetchProducts(pickupLocation: pickUpLocation) { (product, response) in
            productID = product[1].productID
            print("🥒\(productID)")
        }


        ridesClient.fetchPriceEstimates(pickupLocation: pickUpLocation, dropoffLocation: dropOffLocation) { (price, response) in

            print(price[0].estimate!,"🍚")
        }

        ridesClient.fetchTimeEstimates(pickupLocation: pickUpLocation) { (time, response) in
            print("🥕",time[0].estimate,"🥕")
        }
        
        ridesClient.fetchRideRequestEstimate(parameters: builder.build()) { (rideEstimate, response) in
            builder.upfrontFare = rideEstimate?.fare
            print(rideEstimate,"🥗")
        }
        


        builder.productID = productID

        button.setContent()
        button.rideParameters = builder.build()
        button.loadRideInformation()

    }
}
