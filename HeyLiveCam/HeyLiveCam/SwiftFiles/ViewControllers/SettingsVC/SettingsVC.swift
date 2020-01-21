//
//  SettingsVC.swift
//  HeyLiveCam
//
//  Created by Shree on 21/12/19.
//  Copyright © 2019 Shree. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

//MARK: - Settings View Controller
class SettingsVC: UIViewController {

    //TODO: - Outlet Declaration
    @IBOutlet var tblSettings: UITableView!
    @IBOutlet var lblHeaderTitle: UILabel!
    
    //TODO: - Variable Declaration
    var arrSettings = [ModalSettings]()
    var cellSettingsSelected = SettingsSelected.none
    
    var strStartRecordingVideo = ""
    var strStopRecordingVideo = ""
    var strTakePhoto = ""
    var strReverseCamera = ""
    var strCloseHeyCamera = ""
    
    var isCameraSoundEffects = true
    var isVideoResolutionHigh = true
    var trimTheEndOfVideos = 0
    
    //TODO: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        //Initialization
        self.initialization()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Change statusbar color
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.arrSettings.count > 0 {
            
            self.strStartRecordingVideo = UserDefaults.standard.getSettingStartRecordingVideo()
            self.strStopRecordingVideo = UserDefaults.standard.getSettingStopRecordingVideo()
            self.strTakePhoto = UserDefaults.standard.getSettingTakePhoto()
            self.strReverseCamera = UserDefaults.standard.getSettingReverseCamera()
            self.strCloseHeyCamera = UserDefaults.standard.getSettingCloseHeyCamera()
            
            self.isVideoResolutionHigh = UserDefaults.standard.isSettingVideoResolution()
            self.isCameraSoundEffects = UserDefaults.standard.isSettingCameraSoundEffect()
            self.trimTheEndOfVideos = UserDefaults.standard.getSettingTrimTheEndOfVideos()
            
            self.arrSettings[0].arrSettings[0].strSubTitle = strStartRecordingVideo
            self.arrSettings[0].arrSettings[1].strSubTitle = strStopRecordingVideo
            self.arrSettings[0].arrSettings[2].strSubTitle = strTakePhoto
            self.arrSettings[0].arrSettings[3].strSubTitle = strReverseCamera
            self.arrSettings[0].arrSettings[4].strSubTitle = strCloseHeyCamera
            
            arrSettings[2].arrSettings[1].isSwitchOn = self.isCameraSoundEffects
        }
        self.tblSettings.reloadData()
    }
    func initialization() {
        
        self.lblHeaderTitle.text = "Settings".getLocalized()
        
        self.isVideoResolutionHigh = UserDefaults.standard.isSettingVideoResolution()
        self.trimTheEndOfVideos = UserDefaults.standard.getSettingTrimTheEndOfVideos()
        var strVersionNumber = ""
        strVersionNumber = "v"+(Bundle.main.releaseVersionNumber ?? "") + ""
        
        //Voice Command
        var arrSettingsVoiceCommands = [ModalSettingsSubClass]()
        arrSettingsVoiceCommands.append(ModalSettingsSubClass.init(dictData:
            [
                "title":"Start Recording Video".getLocalized(),
                "subTitle":UserDefaults.standard.getSettingStartRecordingVideo(),
                "photo":"imgSettingsVideo",
                "displayDescription":true
            ]
            , cellType: .rightArrowCell))
        
        arrSettingsVoiceCommands.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Stop Recording Video".getLocalized(),
            "subTitle":UserDefaults.standard.getSettingStopRecordingVideo(),
            "photo":"imgSettingsStop",
            "displayDescription":true
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsVoiceCommands.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Take Photo".getLocalized(),
            "subTitle":UserDefaults.standard.getSettingTakePhoto(),
            "photo":"imgSettingsCamera",
            "displayDescription":true
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsVoiceCommands.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Reverse Camera".getLocalized(),
            "subTitle":UserDefaults.standard.getSettingReverseCamera(),
            "photo":"imgSettingsReverse",
            "displayDescription":true
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsVoiceCommands.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Close Hey Camera".getLocalized(),
            "subTitle":UserDefaults.standard.getSettingCloseHeyCamera(),
            "photo":"imgSettingsClose",
            "displayDescription":true
        ]
        , cellType: .rightArrowCell))
        
        arrSettings.append(ModalSettings.init(strSectionName: "Voice Commands".getLocalized(), arrSettings: arrSettingsVoiceCommands))
        
        //Siri Shortcuts
        /*var arrSettingsSiriShortcuts = [ModalSettingsSubClass]()
        arrSettingsSiriShortcuts.append(ModalSettingsSubClass.init(dictData:
            [
                "title":"Take Photo",
                "subTitle":"",
                "photo":"imgSettingsCamera",
                "displayDescription":false
            ]
            , cellType: .plusIconCell))
        
        arrSettingsSiriShortcuts.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Start Recording Video",
            "subTitle":"",
            "photo":"imgSettingsVideo",
            "displayDescription":false
        ]
        , cellType: .plusIconCell))
        
        arrSettings.append(ModalSettings.init(strSectionName: "Siri Shortcuts", arrSettings: arrSettingsSiriShortcuts))*/
        
        var strVideoResolutionHigh = ""
        if(self.isVideoResolutionHigh == true) {
            strVideoResolutionHigh = "1080p HD at 30 fps".getLocalized()
        } else {
            strVideoResolutionHigh = "720p HD at 30 fps".getLocalized()
        }
        
        //Video Settings
        var arrSettingsVideoSettings = [ModalSettingsSubClass]()
        arrSettingsVideoSettings.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Video Resolution".getLocalized(),
            "subTitle":strVideoResolutionHigh,
            "photo":"imgSettingsVideoResolution",
            "displayDescription":true
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsVideoSettings.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Trim the end of videos".getLocalized(),
            "subTitle":"Do not trim".getLocalized(),
            "photo":"imgSettingsTrim",
            "displayDescription":true
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsVideoSettings.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Capture audio with videos".getLocalized(),
            "subTitle":"",
            "photo":"imgSettingsCaptureAudio",
            "displayDescription":false
        ]
        , cellType: .switchButtonCell))
        
        /*arrSettingsVideoSettings.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Keep screen awake",
            "subTitle":"",
            "photo":"imgSettingsMobile",
            "displayDescription":false
        ]
        , cellType: .switchButtonCell))*/
        
        arrSettings.append(ModalSettings.init(strSectionName: "Video Settings".getLocalized(), arrSettings: arrSettingsVideoSettings))
        
        arrSettings[1].arrSettings[2].isSwitchOn = UserDefaults.standard.isSettingCaptureAudioWithVideo()
        //arrSettings[1].arrSettings[3].isSwitchOn = UserDefaults.standard.isSettingKeepScreenAwake()
        
        //Miscellaneous
        var arrSettingsMiscellaneous = [ModalSettingsSubClass]()
        arrSettingsMiscellaneous.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Language".getLocalized(),
            "subTitle":"English".getLocalized(),
            "photo":"imgLanguageIcon",
            "displayDescription":true
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsMiscellaneous.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Restore Purchases".getLocalized(),
            "subTitle":"",
            "photo":"imgSettingsRestore",
            "displayDescription":false
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsMiscellaneous.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Camera Sound Effects".getLocalized(),
            "subTitle":"",
            "photo":"imgCameraSound",
            "displayDescription":false
        ]
        , cellType: .switchButtonCell))
        
        /*arrSettingsMiscellaneous.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Store Geolocation on Media",
            "subTitle":"",
            "photo":"imgSettingsLocation",
            "displayDescription":false
        ]
        , cellType: .switchButtonCell))*/
        
        arrSettingsMiscellaneous.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Share This App".getLocalized(),
            "subTitle":"",
            "photo":"imgSettingsShare",
            "displayDescription":false
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsMiscellaneous.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Rate This App".getLocalized(),
            "subTitle":"",
            "photo":"imgSettingsLike",
            "displayDescription":false
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsMiscellaneous.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Help".getLocalized(),
            "subTitle":"",
            "photo":"imgSettingsHelp",
            "displayDescription":false
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsMiscellaneous.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Send Feedback".getLocalized(),
            "subTitle":"",
            "photo":"imgSettingsSend",
            "displayDescription":false
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsMiscellaneous.append(ModalSettingsSubClass.init(dictData:
        [
            "title":strVersionNumber,
            "subTitle":"",
            "photo":"imgSettingsSend",
            "displayDescription":false
        ]
        , cellType: .plainCell))
        
        arrSettings.append(ModalSettings.init(strSectionName: "Miscellaneous".getLocalized(), arrSettings: arrSettingsMiscellaneous))
        arrSettings[2].arrSettings[2].isSwitchOn = UserDefaults.standard.isSettingCameraSoundEffect()
        //arrSettings[2].arrSettings[2].isSwitchOn = UserDefaults.standard.isSettingStoreGeolocationOnMedia()
        
        self.tblSettings.reloadData()
    }
    func openLanguageSelectionPopup() {
        let optionMenu = UIAlertController(title: nil, message: "Language".getLocalized(), preferredStyle: .actionSheet)
        let actionEnglish = UIAlertAction(title: "English".getLocalized(), style: .default) { action -> Void in
            print("English")
            Bundle.setLanguage(lang: "en")
            let deadlineTime = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                self.arrSettings[2].arrSettings[0].strSubTitle = "English".getLocalized()
                self.tblSettings.reloadData()
                
                //Redirect To Back Screen
                self.redirectToBackScreen()
            }
            
            //Set Setting Video Resolution
            //UserDefaults.standard.setSettingVideoResolution(value: true)
        }
        let actionJapanese = UIAlertAction(title: "Japanese".getLocalized(), style: .default) { action -> Void in
            print("Japanese")
            
            Bundle.setLanguage(lang: "ja")
            let deadlineTime = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                self.arrSettings[2].arrSettings[0].strSubTitle = "Japanese".getLocalized()
                self.tblSettings.reloadData()
                
                //Redirect To Back Screen
                self.redirectToBackScreen()
            }
            
            //Set Setting Video Resolution
            //UserDefaults.standard.setSettingVideoResolution(value: false)
        }
        let cancelAction = UIAlertAction(title: "Cancel".getLocalized(), style: .cancel)
        optionMenu.addAction(actionEnglish)
        optionMenu.addAction(actionJapanese)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    func openVideoResolutionPopup() {
        let optionMenu = UIAlertController(title: nil, message: "Video Resolution".getLocalized(), preferredStyle: .actionSheet)
        let actionHighResolution = UIAlertAction(title: "1080p HD at 30 fps".getLocalized(), style: .default) { action -> Void in
            print("High Resolution")
            self.arrSettings[1].arrSettings[0].strSubTitle = "1080p HD at 30 fps".getLocalized()
            self.tblSettings.reloadData()
            
            //Set Setting Video Resolution
            self.isVideoResolutionHigh = true
            UserDefaults.standard.setSettingVideoResolution(value: true)
        }
        let actionMediamResolution = UIAlertAction(title: "720p HD at 30 fps".getLocalized(), style: .default) { action -> Void in
            print("Mediam Resolution")
            self.arrSettings[1].arrSettings[0].strSubTitle = "720p HD at 30 fps".getLocalized()
            self.tblSettings.reloadData()
            
            //Set Setting Video Resolution
            self.isVideoResolutionHigh = false
            UserDefaults.standard.setSettingVideoResolution(value: false)
        }
        let cancelAction = UIAlertAction(title: "Cancel".getLocalized(), style: .cancel)
        optionMenu.addAction(actionHighResolution)
        optionMenu.addAction(actionMediamResolution)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    func openTrimTheEndOfVideos() {
        let optionMenu = UIAlertController(title: nil, message: "You can use this feature to remove a voice command from the end of a video.".getLocalized(), preferredStyle: .actionSheet)
        let actionDoNotTrim = UIAlertAction(title: "Do not trim".getLocalized(), style: .default) { action -> Void in
            print("Do not trim")
            
            self.arrSettings[1].arrSettings[1].strSubTitle = "Do not trim".getLocalized()
            self.tblSettings.reloadData()
        }
        let action_1_second = UIAlertAction(title: "1 second".getLocalized(), style: .default) { action -> Void in
            print("1 second")
            self.arrSettings[1].arrSettings[1].strSubTitle = "1 second".getLocalized()
            self.tblSettings.reloadData()
        }
        let action_2_second = UIAlertAction(title: "2 seconds".getLocalized(), style: .default) { action -> Void in
            print("2 seconds")
            self.arrSettings[1].arrSettings[1].strSubTitle = "2 seconds".getLocalized()
            self.tblSettings.reloadData()
        }
        let action_3_second = UIAlertAction(title: "3 seconds".getLocalized(), style: .default) { action -> Void in
            print("3 seconds")
            self.arrSettings[1].arrSettings[1].strSubTitle = "3 seconds".getLocalized()
            self.tblSettings.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel".getLocalized(), style: .cancel)
        optionMenu.addAction(actionDoNotTrim)
        optionMenu.addAction(action_1_second)
        optionMenu.addAction(action_2_second)
        optionMenu.addAction(action_3_second)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    func openShareBox() {
        let text = "Hey Live Cam...".getLocalized()
            let textShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
    }
    func rateThisApp() {
        guard let url = URL(string: strRateAppUrl) else {
            return
        }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)

        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
//MARK: - UITableViewDelegate
extension SettingsVC:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrSettings.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrSettings[section].arrSettings.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CellSettings", for: indexPath) as! CellSettings
        let data = self.arrSettings[indexPath.section].arrSettings[indexPath.row]
        
        if (self.arrSettings[indexPath.section].arrSettings.count-1) == indexPath.row {
            cell.viewSeperator.isHidden = true
        } else {
            cell.viewSeperator.isHidden = false
        }
        
        cell.switchSetting.tag = (indexPath.section * 100) + (indexPath.row)
        cell.switchSetting.isOn = data.isSwitchOn
        
        if(data.cellType == .rightArrowCell) {
            
            if(data.isDisplayDescription == false) {
                cell.viewDoubleLineBG.isHidden = true
                cell.viewSingleLineBG.isHidden = false
                
                cell.lblSingleLineTitle.text = data.strTitle
                cell.lblSingleLineTitle.textAlignment = .left
            } else {
                cell.viewDoubleLineBG.isHidden = false
                cell.viewSingleLineBG.isHidden = true
                
                cell.lblDoubleLineTitle.text = data.strTitle
                cell.lblDoubleLineSubTitle.text = "\"" + data.strSubTitle + "\""
            }
            
            cell.switchSetting.isHidden = true
            cell.imgSettingIcon.isHidden = false
            cell.imgRightIcon.isHidden = false
            cell.imgRightIcon.image = UIImage.init(named: "imgRightArrow")
            cell.imgSettingIcon.image = UIImage.init(named: data.strPhoto)
            
        } else if(data.cellType == .plusIconCell) {
            
            cell.viewDoubleLineBG.isHidden = true
            cell.viewSingleLineBG.isHidden = false
            
            cell.lblSingleLineTitle.text = data.strTitle
            cell.lblSingleLineTitle.textAlignment = .left
            
            cell.switchSetting.isHidden = true
            cell.imgSettingIcon.isHidden = false
            cell.imgRightIcon.isHidden = false
            cell.imgRightIcon.image = UIImage.init(named: "imgPlusIcon")
            cell.imgSettingIcon.image = UIImage.init(named: data.strPhoto)
            
        } else if(data.cellType == .switchButtonCell) {
                   
           cell.viewDoubleLineBG.isHidden = true
           cell.viewSingleLineBG.isHidden = false
           
           cell.lblSingleLineTitle.text = data.strTitle
           cell.lblSingleLineTitle.textAlignment = .left
           
           cell.switchSetting.isHidden = false
            cell.switchSetting.isOn = data.isSwitchOn
           cell.imgSettingIcon.isHidden = false
           cell.imgRightIcon.isHidden = true
           cell.imgRightIcon.image = UIImage.init(named: "imgPlusIcon")
           cell.imgSettingIcon.image = UIImage.init(named: data.strPhoto)
                   
        } else if(data.cellType == .plainCell) {
            
            cell.viewSingleLineBG.isHidden = false
            cell.viewDoubleLineBG.isHidden = true
            cell.imgSettingIcon.isHidden = true
            cell.imgRightIcon.isHidden = true
            cell.switchSetting.isHidden = true
            
            cell.lblSingleLineTitle.text = data.strTitle
            cell.lblSingleLineTitle.textAlignment = .center
            
        } else {
            cell.viewDoubleLineBG.isHidden = true
            cell.viewSingleLineBG.isHidden = false
            
        }
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        //Voice Commands
        if indexPath.section == 0 {
            
            //Redirect To Voice Text Update Screen
            self.cellSettingsSelected = .none
            if indexPath.row == 0 {
                self.cellSettingsSelected = .startRecordingVideo
            } else if indexPath.row == 1 {
                self.cellSettingsSelected = .stopRecordingVideo
            } else if indexPath.row == 2 {
                self.cellSettingsSelected = .takePhoto
            } else if indexPath.row == 3 {
                self.cellSettingsSelected = .reverseCamera
            } else if indexPath.row == 4 {
                self.cellSettingsSelected = .closeHeyCamera
            }
            //Redirect To Voice Text Update Screen
            self.redirectToVoiceTextUpdateScreen(cellSettingsSelected: self.cellSettingsSelected)
            
        } else if(indexPath.section == 1) {
           //Video Settings
            
            if(indexPath.row == 0) {
                //Video Resolution
                
                //Open Video Resolution Popup
                self.openVideoResolutionPopup()
                
            } else if(indexPath.row == 1) {
                //Trim the end of videos
                
                //Open Trim The End Of Videos
                self.openTrimTheEndOfVideos()
            }
        } else if(indexPath.section == 2) {
            //Miscellaneous
            if(indexPath.row == 0) {
                    
                //Open Language Selection Popup
                self.openLanguageSelectionPopup()
                
            } else if(indexPath.row == 3) {
                    
                //Share this app
                self.openShareBox()
                
            } else if(indexPath.row == 4) {
            
                //Rate This App
                self.rateThisApp()
            } else if(indexPath.row == 5) {
                
                //Redirect To Help Screen
                self.redirectToHelpScreen()
                
            } else if(indexPath.row == 6) {
                
                //Send Feedback
                self.sendFeedback()
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 36
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let viewSection = UIView(frame: CGRect(x: 0, y: 0, width: Int(tableView.bounds.width), height: 36))
        viewSection.clipsToBounds = true
        viewSection.backgroundColor = UIColor.init(red: 240/255, green: 239/255, blue: 245/255, alpha: 1.0)
        
        //Title
        let lblTitle = UILabel.init(frame: CGRect(x: 20, y: 0, width: viewSection.frame.size.width-20, height: viewSection.frame.size.height))
        lblTitle.textAlignment = .left
        lblTitle.backgroundColor = .clear
        lblTitle.font = UIFont.init(name: "Arial", size: 14)
        lblTitle.textColor = UIColor.init(red: 136/255, green: 136/255, blue: 136/255, alpha: 1.0)
        lblTitle.text = self.arrSettings[section].strSectionName
        viewSection.addSubview(lblTitle)
        
        return viewSection
    }
}
//MARK: - Tapped Event
extension SettingsVC {
    @IBAction func tappedOnBack(_ sender: Any) {
        
        //Redirect To Back Screen
        self.redirectToBackScreen()
    }
    @IBAction func tappedOnSwitch(_ sender: Any) {
        let switchStatus = sender as! UISwitch
        print("switchStatus : ",switchStatus.tag)
        let index = switchStatus.tag
        if(index>=100 && index<200) {
            let finalIndex = index-100
            self.arrSettings[1].arrSettings[finalIndex].isSwitchOn = !self.arrSettings[1].arrSettings[finalIndex].isSwitchOn
            
            if(finalIndex == 2) {
                UserDefaults.standard.setSettingCaptureAudioWithVideo(value: self.arrSettings[1].arrSettings[finalIndex].isSwitchOn)
            }/* else if(finalIndex == 3) {
                UserDefaults.standard.setSettingKeepScreenAwake(value: self.arrSettings[1].arrSettings[finalIndex].isSwitchOn)
            }*/
            
        } else if(switchStatus.tag>=200) {
            let finalIndex = index-200
            self.arrSettings[2].arrSettings[finalIndex].isSwitchOn = !self.arrSettings[2].arrSettings[finalIndex].isSwitchOn
            
            if finalIndex == 1 {
                UserDefaults.standard.setSettingCameraSoundEffect(value: self.arrSettings[2].arrSettings[finalIndex].isSwitchOn)
            }/* else if (finalIndex == 2) {
                UserDefaults.standard.setSettingStoreGeolocationOnMedia(value: self.arrSettings[2].arrSettings[finalIndex].isSwitchOn)
            }*/
        }
        
        self.tblSettings.reloadData()
    }
}
//MARK: - Redirect to next screen
extension SettingsVC {

    func redirectToBackScreen() {
        self.navigationController?.popViewController(animated: true)
    }
    func redirectToVoiceTextUpdateScreen(cellSettingsSelected:SettingsSelected) {
        
        let vcVoiceTextUpdate = self.storyboard?.instantiateViewController(withIdentifier: "VoiceTextUpdateVC") as! VoiceTextUpdateVC
        vcVoiceTextUpdate.cellSettingsSelected = cellSettingsSelected
        self.navigationController?.pushViewController(vcVoiceTextUpdate, animated: true)
    }
    func redirectToHelpScreen() {
        
        let vcHelp = self.storyboard?.instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
        self.navigationController?.pushViewController(vcHelp, animated: true)
    }
}
//MARK: - MFMailComposeViewControllerDelegate
extension SettingsVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
      controller.dismiss(animated: true)
    }
    func sendFeedback() {
       
        let strRecipients = "mailto:\(strSendFeedBackMailID)?cc=&subject=\(strSendFeedBackMailSubject)";
        let strBody = "&body=";
        let strEmail = strRecipients + strBody
        if let strFinalUrl = strEmail.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            
            if let urlEmail = URL.init(string: strFinalUrl) {
               if #available(iOS 10.0, *) {
                   UIApplication.shared.open(urlEmail, options: [:], completionHandler: nil)
               } else {
                   UIApplication.shared.openURL(urlEmail)
               }
            }
        }
    }
}

//MARK: - TableViewCell
class CellSettings:UITableViewCell {
    
    @IBOutlet var viewSeperator: UIView!
    @IBOutlet var imgSettingIcon: UIImageView!
    @IBOutlet var switchSetting: UISwitch!
    @IBOutlet var imgRightIcon: UIImageView!
    @IBOutlet var lblSingleLineTitle: UILabel!
    @IBOutlet var lblDoubleLineTitle: UILabel!
    @IBOutlet var lblDoubleLineSubTitle: UILabel!
    @IBOutlet var viewSingleLineBG: UIView!
    @IBOutlet var viewDoubleLineBG: UIView!
}

//MARK: - Modal Settings
class ModalSettings:NSObject {
    
    var strSectionName = ""
    var arrSettings = [ModalSettingsSubClass]()
    
    override init() {
        
    }
    init(strSectionName:String,arrSettings:[ModalSettingsSubClass]) {
        self.strSectionName = strSectionName
        self.arrSettings = arrSettings
    }
}

class ModalSettingsSubClass:NSObject {
    var strTitle = ""
    var strSubTitle = ""
    var strPhoto = ""
    var cellType = ModalSettingCellType.plainCell
    var isSwitchOn = true
    var isDisplayDescription = false
    
    override init() {
        
    }
    init(dictData:[String:Any],cellType:ModalSettingCellType) {
        
        self.strTitle = dictData["title"] as! String
        self.strSubTitle = dictData["subTitle"] as! String
        self.strPhoto = dictData["photo"] as! String
        self.isDisplayDescription = dictData["displayDescription"] as! Bool
        self.cellType = cellType
    }
}

//MARK: - Modal Setting Cell Type
enum ModalSettingCellType {
    case rightArrowCell
    case switchButtonCell
    case plusIconCell
    case plainCell
}

//MARK: - Modal Setting Cell Type
enum SettingsSelected {
    case startRecordingVideo
    case stopRecordingVideo
    case takePhoto
    case reverseCamera
    case closeHeyCamera
    case none
}
