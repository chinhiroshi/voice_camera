//
//  VoiceTextUpdateVC.swift
//  HeyLiveCam
//
//  Created by Shree on 24/12/19.
//  Copyright © 2019 Shree. All rights reserved.
//

import UIKit

//MARK: - Voice Text Update View Controller
class VoiceTextUpdateVC: UIViewController {

    //TODO: - Outlet Declaration
    @IBOutlet var viewTextBG: UIView!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var lblDescription: UILabel!
    
    //TODO: - Variable Declaration
    var cellSettingsSelected = SettingsSelected.none
    var strDescription = ""
    var strTitle = ""
    
    //TODO: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        //Initialization
        self.initialization()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let strName = txtName.text?.trimmingCharacters(in: .whitespaces)
        if strName?.count ?? 0 > 0 {
            
            if(self.cellSettingsSelected == .startRecordingVideo) {
                UserDefaults.standard.setSettingStartRecordingVideo(value: strName ?? "")
                
            } else if(self.cellSettingsSelected == .stopRecordingVideo) {
                UserDefaults.standard.setSettingStopRecordingVideo(value: strName ?? "")
                
            } else if(self.cellSettingsSelected == .takePhoto) {
                UserDefaults.standard.setSettingTakePhoto(value: strName ?? "")
                
            } else if(self.cellSettingsSelected == .reverseCamera) {
                UserDefaults.standard.setSettingReverseCamera(value: strName ?? "")
                
            } else if(self.cellSettingsSelected == .closeHeyCamera) {
                UserDefaults.standard.setSettingCloseHeyCamera(value: strName ?? "")
                
            }
        }
    }
    func initialization() {
        
        self.viewTextBG.layer.borderWidth = 1
        self.viewTextBG.layer.borderColor = UIColor.init(red: 154/255, green: 154/255, blue: 154/255, alpha: 1.0).cgColor
        
        if(self.cellSettingsSelected == .startRecordingVideo) {
            
            self.strDescription = "Enter a pharse to use for starting a video recording."
            self.strTitle = UserDefaults.standard.getSettingStartRecordingVideo()
            
        } else if(self.cellSettingsSelected == .stopRecordingVideo) {
            
            self.strDescription = "Enter a pharse to use for stopping a video recording."
            self.strTitle = UserDefaults.standard.getSettingStopRecordingVideo()
            
        } else if(self.cellSettingsSelected == .takePhoto) {
            
            self.strDescription = "Enter a pharse to use for taking a photo."
            self.strTitle = UserDefaults.standard.getSettingTakePhoto()
            
        } else if(self.cellSettingsSelected == .reverseCamera) {
            
            self.strDescription = "Enter a pharse to use for reversing the camera."
            self.strTitle = UserDefaults.standard.getSettingReverseCamera()
            
        } else if(self.cellSettingsSelected == .closeHeyCamera) {
            
            self.strDescription = "Enter a pharse to use for closing Hey Camera(useful to get back to sign)."
            self.strTitle = UserDefaults.standard.getSettingCloseHeyCamera()

        }
        
        self.lblDescription.text = strDescription
        self.txtName.text = strTitle
        self.txtName.becomeFirstResponder()
    }
    @IBAction func tappedOnBack(_ sender: Any) {
        
        //Redirect To Back Screen
        self.redirectToBackScreen()
    }
}
//MARK: - UITextFieldDelegate
extension VoiceTextUpdateVC:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

//MARL: - Redirect To Next Screen
extension VoiceTextUpdateVC {
    
    func redirectToBackScreen() {
        self.navigationController?.popViewController(animated: true)
    }
}
