//
//  InAppPurchaseVC.swift
//  HeyLiveCam
//
//  Created by Shree on 21/12/19.
//  Copyright © 2019 Shree. All rights reserved.
//

import UIKit

//MARK: - In App Purchase VC
class InAppPurchaseVC: UIViewController {

    //TODO: - Outlet Declaration
    @IBOutlet var controlPurchaseUnlimited: UIControl!
    @IBOutlet var lblPurchaseUnlimited: UILabel!
    
    
    //TODO: - Variable Declaration
    var strRupees = "79.00"
    
    
    //TODO: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        //Initialization
        self.initialization()
    }
    func initialization() {
        
        controlPurchaseUnlimited.layer.cornerRadius = 8
        lblPurchaseUnlimited.text = "Purchase Unlimited - ₹ " + strRupees;
    }
}
//MARK: - Tapped Event
extension InAppPurchaseVC {
    @IBAction func tappedOnClose(_ sender: Any) {
        
        //Redirect To Back
        self.redirectToBack()
    }
    @IBAction func tappedOnPurchaseUnlimited(_ sender: Any) {
        
    }
}
//MARK: - Redirect to next view
extension InAppPurchaseVC {

    //Redirect To Back
    func redirectToBack() {
        dismiss(animated: true, completion: nil)
    }
}
