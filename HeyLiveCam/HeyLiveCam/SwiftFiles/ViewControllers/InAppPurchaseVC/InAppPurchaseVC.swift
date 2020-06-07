//
//  InAppPurchaseVC.swift
//  HeyLiveCam
//
//  Created by Shree on 21/12/19.
//  Copyright © 2019 Shree. All rights reserved.
//

import UIKit
import IAPurchaseManager

//MARK: - In App Purchase VC
class InAppPurchaseVC: UIViewController {

    //TODO: - Outlet Declaration
    @IBOutlet var controlPurchaseUnlimited: UIControl!
    @IBOutlet var lblPurchaseUnlimited: UILabel!
    @IBOutlet var lblDescription: UILabel!
    
    //TODO: - Variable Declaration
    var strPrice = ""
    var loaderView: LoaderView?
    
    //TODO: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        //Initialization
        self.initialization()
    }
    func initialization() {
        
        //strPrice
        strPrice = UserDefaults.Main.string(forKey: .in_app_purchase_price)
        
        controlPurchaseUnlimited.layer.cornerRadius = 8
        lblPurchaseUnlimited.text = "Purchase Unlimited - ".getLocalized() + strPrice;
        lblDescription.text = "You have reached the maximum number of captures allowed in the free version. Purchase Unlimited to continue capturing photos and videos.".getLocalized()
    }
    func buyPremiumFeature() {
        
        showLoaderView(with: "")
        IAPManager.shared.purchaseProduct(productId: strInAppPurchase) { (error) -> Void in
            if error == nil {
                print("successful purchase!")
            } else {
                print("something wrong..")
                print(error ?? "NIL")
            }
            
            //Redirect To Back
            self.redirectToBack()
            
            //Hide Loader
            self.hideLoader()
        }
    }
}

// MARK: - Show / Hide loader for purchase and restore
extension InAppPurchaseVC {
    func showLoaderView(with title:String) {
        loaderView = LoaderView.instanceFromNib()
        loaderView?.lblLoaderTitle.text = title
        loaderView?.frame = self.view.frame
        self.view.addSubview(loaderView!)
    }

    func hideLoader() {
        if loaderView != nil {
            loaderView?.removeFromSuperview()
        }
    }
}

//MARK: - Tapped Event
extension InAppPurchaseVC {
    @IBAction func tappedOnClose(_ sender: Any) {
        
        //Redirect To Back
        self.redirectToBack()
    }
    @IBAction func tappedOnPurchaseUnlimited(_ sender: Any) {
        
        //Buy Premium Feature
        self.buyPremiumFeature()
    }
}
//MARK: - Redirect to next view
extension InAppPurchaseVC {

    //Redirect To Back
    func redirectToBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
