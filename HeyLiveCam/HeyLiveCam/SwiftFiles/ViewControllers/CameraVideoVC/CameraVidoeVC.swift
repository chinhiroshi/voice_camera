//
//  CameraVidoeVC.swift
//  HeyLiveCam
//
//  Created by Shree on 21/12/19.
//  Copyright © 2019 Shree. All rights reserved.
//

import UIKit

//MARK: - View Controller
class CameraVidoeVC: UIViewController {

    //TODO: - Outlet Declaration
    @IBOutlet var capturePreviewView: UIView!
    @IBOutlet var captureButton: UIButton!
    @IBOutlet var toggleFlashButton: UIButton!
    @IBOutlet var toggleCameraButton: UIButton!
    @IBOutlet var photoModeButton: UIButton!
    @IBOutlet var videoModeButton: UIButton!
    
    
    //TODO: - Variable Declaration
    let cameraController = CameraController()
    override var prefersStatusBarHidden: Bool { return true }
    
    
    //TODO: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        styleCaptureButton()
        configureCameraController()
    }
    func styleCaptureButton() {
        captureButton.layer.borderColor = UIColor.black.cgColor
        captureButton.layer.borderWidth = 2
        
        captureButton.layer.cornerRadius = min(captureButton.frame.width, captureButton.frame.height) / 2
    }
    func configureCameraController() {
        cameraController.prepare {(error) in
            if let error = error {
                print(error)
            }
            
            try? self.cameraController.displayPreview(on: self.capturePreviewView)
        }
    }
}
extension CameraVidoeVC {
    @IBAction func captureImage(_ sender: Any) {
        
        //Redirect To Purchase Unlimited Screen
        self.redirectToPurchaseUnlimitedScreen()
        
        /*cameraController.captureImage {(image, error) in
            guard let image = image else {
                print(error ?? "Image capture error")
                return
            }
            print("AA")
            print("BB")
            /*try? PHPhotoLibrary.shared().performChangesAndWait {
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            }*/
        }*/
    }
    @IBAction func toggleFlash(_ sender: Any) {
        if cameraController.flashMode == .on {
            cameraController.flashMode = .off
            toggleFlashButton.setImage(#imageLiteral(resourceName: "Flash Off Icon"), for: .normal)
        }
            
        else {
            cameraController.flashMode = .on
            toggleFlashButton.setImage(#imageLiteral(resourceName: "Flash On Icon"), for: .normal)
        }
    }
    @IBAction func switchCameras(_ sender: Any) {
        do {
            try cameraController.switchCameras()
        }
            
        catch {
            print(error)
        }
        
        switch cameraController.currentCameraPosition {
        case .some(.front):
            toggleCameraButton.setImage(#imageLiteral(resourceName: "Front Camera Icon"), for: .normal)
            
        case .some(.rear):
            toggleCameraButton.setImage(#imageLiteral(resourceName: "Rear Camera Icon"), for: .normal)
            
        case .none:
            return
        }
    }
}
//MARK: - Redirect to next view
extension CameraVidoeVC {
    
    //Redirect To Purchase Unlimited Screen
    func redirectToPurchaseUnlimitedScreen() {
        
        let vcInAppPurchase = self.storyboard?.instantiateViewController(withIdentifier: "InAppPurchaseVC") as! InAppPurchaseVC
        self.present(vcInAppPurchase, animated: true, completion: nil)
    }
}
