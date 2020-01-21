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
    @IBOutlet var lblDescription: UILabel!
    
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
        lblPurchaseUnlimited.text = "Purchase Unlimited - ₹ ".getLocalized() + strRupees;
        lblDescription.text = "You have reached the maximum number of captures allowed in the free version. Purchase Unlimited to continue capturing photos and videos.".getLocalized()
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
