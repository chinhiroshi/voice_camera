//
//  SettingsVC.swift
//  HeyLiveCam
//
//  Created by Shree on 21/12/19.
//  Copyright © 2019 Shree. All rights reserved.
//

import UIKit

//MARK: - Settings View Controller
class SettingsVC: UIViewController {

    //TODO: - Outlet Declaration
    @IBOutlet var tblSettings: UITableView!
    
    //TODO: - Variable Declaration
    var arrSettings = [ModalSettings]()
    var cellSettingsSelected = SettingsSelected.none
    
    var strStartRecordingVideo = ""
    var strStopRecordingVideo = ""
    var strTakePhoto = ""
    var strReverseCamera = ""
    var strCloseHeyCamera = ""
    
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
            
            self.arrSettings[0].arrSettings[0].strSubTitle = strStartRecordingVideo
            self.arrSettings[0].arrSettings[1].strSubTitle = strStopRecordingVideo
            self.arrSettings[0].arrSettings[2].strSubTitle = strTakePhoto
            self.arrSettings[0].arrSettings[3].strSubTitle = strReverseCamera
            self.arrSettings[0].arrSettings[4].strSubTitle = strCloseHeyCamera
        }
        self.tblSettings.reloadData()
    }
    func initialization() {
        
        //Voice Command
        var arrSettingsVoiceCommands = [ModalSettingsSubClass]()
        arrSettingsVoiceCommands.append(ModalSettingsSubClass.init(dictData:
            [
                "title":"Start Recording Video",
                "subTitle":UserDefaults.standard.getSettingStartRecordingVideo(),
                "photo":"imgSettingsVideo",
                "displayDescription":true
            ]
            , cellType: .rightArrowCell))
        
        arrSettingsVoiceCommands.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Stop Recording Video",
            "subTitle":UserDefaults.standard.getSettingStopRecordingVideo(),
            "photo":"imgSettingsStop",
            "displayDescription":true
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsVoiceCommands.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Take Photo",
            "subTitle":UserDefaults.standard.getSettingTakePhoto(),
            "photo":"imgSettingsCamera",
            "displayDescription":true
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsVoiceCommands.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Reverse Camera",
            "subTitle":UserDefaults.standard.getSettingReverseCamera(),
            "photo":"imgSettingsReverse",
            "displayDescription":true
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsVoiceCommands.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Close Hey Camera",
            "subTitle":UserDefaults.standard.getSettingCloseHeyCamera(),
            "photo":"imgSettingsClose",
            "displayDescription":true
        ]
        , cellType: .rightArrowCell))
        
        arrSettings.append(ModalSettings.init(strSectionName: "Voice Commands", arrSettings: arrSettingsVoiceCommands))
        
        //Siri Shortcuts
        var arrSettingsSiriShortcuts = [ModalSettingsSubClass]()
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
        
        arrSettings.append(ModalSettings.init(strSectionName: "Siri Shortcuts", arrSettings: arrSettingsSiriShortcuts))
        
        //Video Settings
        var arrSettingsVideoSettings = [ModalSettingsSubClass]()
        arrSettingsVideoSettings.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Video Resolution",
            "subTitle":"1080p HD at 30 fps",
            "photo":"imgSettingsVideoResolution",
            "displayDescription":true
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsVideoSettings.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Trim the end of videos",
            "subTitle":"Do not trim",
            "photo":"imgSettingsTrim",
            "displayDescription":true
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsVideoSettings.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Capture audio with videos",
            "subTitle":"",
            "photo":"imgSettingsCaptureAudio",
            "displayDescription":false
        ]
        , cellType: .switchButtonCell))
        
        arrSettingsVideoSettings.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Keep screen awake",
            "subTitle":"",
            "photo":"imgSettingsMobile",
            "displayDescription":false
        ]
        , cellType: .switchButtonCell))
        
        arrSettings.append(ModalSettings.init(strSectionName: "Video Settings", arrSettings: arrSettingsVideoSettings))
        
        arrSettings[2].arrSettings[2].isSwitchOn = UserDefaults.standard.isSettingCaptureAudioWithVideo()
        arrSettings[2].arrSettings[3].isSwitchOn = UserDefaults.standard.isSettingKeepScreenAwake()
        
        //Miscellaneous
        var arrSettingsMiscellaneous = [ModalSettingsSubClass]()
        arrSettingsMiscellaneous.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Restore Purchases",
            "subTitle":"",
            "photo":"imgSettingsRestore",
            "displayDescription":false
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsMiscellaneous.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Camera Sound Effects",
            "subTitle":"",
            "photo":"imgCameraSound",
            "displayDescription":false
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsMiscellaneous.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Store Geolocation on Media",
            "subTitle":"",
            "photo":"imgSettingsLocation",
            "displayDescription":false
        ]
        , cellType: .switchButtonCell))
        
        arrSettingsMiscellaneous.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Share This App",
            "subTitle":"",
            "photo":"imgSettingsShare",
            "displayDescription":false
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsMiscellaneous.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Rate This App",
            "subTitle":"",
            "photo":"imgSettingsLike",
            "displayDescription":false
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsMiscellaneous.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Help",
            "subTitle":"",
            "photo":"imgSettingsHelp",
            "displayDescription":false
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsMiscellaneous.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"Send Feedback",
            "subTitle":"",
            "photo":"imgSettingsSend",
            "displayDescription":false
        ]
        , cellType: .rightArrowCell))
        
        arrSettingsMiscellaneous.append(ModalSettingsSubClass.init(dictData:
        [
            "title":"v2.0.3.2",
            "subTitle":"",
            "photo":"imgSettingsSend",
            "displayDescription":false
        ]
        , cellType: .plainCell))
        
        arrSettings.append(ModalSettings.init(strSectionName: "Miscellaneous", arrSettings: arrSettingsMiscellaneous))
        arrSettings[3].arrSettings[2].isSwitchOn = UserDefaults.standard.isSettingStoreGeolocationOnMedia()
        
        self.tblSettings.reloadData()
    }
    func openShareBox() {
        let text = "Hey Live Cam..."
            let textShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
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
            
        } else if(indexPath.section == 3) {
            
            if(indexPath.row == 3) {
                
                self.openShareBox()
                
            } else if(indexPath.row == 5) {
                
                //Redirect To Help Screen
                self.redirectToHelpScreen()
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
        if(index>=200 && index<300) {
            let finalIndex = index-200
            self.arrSettings[2].arrSettings[finalIndex].isSwitchOn = !self.arrSettings[2].arrSettings[finalIndex].isSwitchOn
            
            if(finalIndex == 2) {
                UserDefaults.standard.setSettingCaptureAudioWithVideo(value: self.arrSettings[2].arrSettings[finalIndex].isSwitchOn)
            } else if(finalIndex == 3) {
                UserDefaults.standard.setSettingKeepScreenAwake(value: self.arrSettings[2].arrSettings[finalIndex].isSwitchOn)
            }
            
        } else if(switchStatus.tag>=300) {
            let finalIndex = index-300
            self.arrSettings[3].arrSettings[finalIndex].isSwitchOn = !self.arrSettings[3].arrSettings[finalIndex].isSwitchOn
            
            UserDefaults.standard.setSettingStoreGeolocationOnMedia(value: self.arrSettings[3].arrSettings[finalIndex].isSwitchOn)
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
