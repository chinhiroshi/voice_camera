//
//  HelpVC.swift
//  HeyLiveCam
//
//  Created by Shree on 24/12/19.
//  Copyright © 2019 Shree. All rights reserved.
//

import UIKit

//MARK: - Help View Controller
class HelpVC: UIViewController {

    //TODO: - Oultlet Declaration
    @IBOutlet var tblHelpList: UITableView!
    @IBOutlet var lblHeaderTitle: UILabel!
    
    
    //TODO: - Variable Declaration
    var arrHelp = [ModalHelpData]()
    
    //TODO: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Initialization
        self.initialization()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Expand Section
        self.expandSection(section: 0)
    }
    func initialization() {
        
        //Set Header Title
        self.lblHeaderTitle.text = "Help".getLocalized()
        
        tblHelpList.rowHeight = UITableView.automaticDimension
        tblHelpList.estimatedRowHeight = UITableView.automaticDimension
        
        var arrHelpCell1 = [ModalHelpDataObject]()
        arrHelpCell1.append(ModalHelpDataObject.init(strDescription: "If voice commands are not working for you please force close the app and re-open it. Also make sure that your Wi-Fi or cellular data connection is online and good. Poor connectivity can cause the speech recognition to fail.".getLocalized()))
        self.arrHelp.append(ModalHelpData.init(strTitle: "Voice commands not working?".getLocalized(), arrHelp: arrHelpCell1,isExpandable: true))
        
        var arrHelpCell2 = [ModalHelpDataObject]()
        arrHelpCell2.append(ModalHelpDataObject.init(strDescription: "The voice command to reverse the camera will toggle the front and back camera. Some users have not been aware that they can return to the back facing camera by saying reverse again.".getLocalized()))
        self.arrHelp.append(ModalHelpData.init(strTitle: "How do I \"un-reverse\" the camera?".getLocalized(), arrHelp: arrHelpCell2,isExpandable: false))
        
        var arrHelpCell3 = [ModalHelpDataObject]()
        arrHelpCell3.append(ModalHelpDataObject.init(strDescription: "Siri Shortcuts functionality is only available in iOS 12 and later.".getLocalized()))
        self.arrHelp.append(ModalHelpData.init(strTitle: "Why are Siri Shortcuts not available for me?".getLocalized(), arrHelp: arrHelpCell3,isExpandable: false))
        
        self.tblHelpList.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Change statusbar color
        UIApplication.shared.statusBarStyle = .default
    }
}
//MARK: - UITableViewDelegate
extension HelpVC:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrHelp.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.arrHelp[section].isExpandable) {
            return self.arrHelp[section].arrHelp.count
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CellHelpList", for: indexPath) as! CellHelpList
        let data = self.arrHelp[indexPath.section].arrHelp[indexPath.row]
        cell.lblDescription.text = data.strDescription
        
        return cell
    }
    // UITableViewAutomaticDimension calculates height of label contents/text
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 36
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //Background
        let viewSection = UIView(frame: CGRect(x: 0, y: 0, width: Int(tableView.bounds.width), height: 36))
        viewSection.clipsToBounds = true
        viewSection.backgroundColor = UIColor.init(red: 240/255, green: 239/255, blue: 245/255, alpha: 1.0)
        viewSection.tag = section
        
        //Down Arrow
        let viewDownArrow = UIView(frame: CGRect(x: viewSection.frame.size.width-40, y: 0, width: 40, height: viewSection.frame.size.height))
        viewDownArrow.backgroundColor = .clear
        viewDownArrow.isUserInteractionEnabled = false
        viewSection.addSubview(viewDownArrow)
        
        let imgArrow  = UIImageView(frame:CGRect(x: 12, y: 10, width: 16, height: 16));
        if(self.arrHelp[section].isExpandable) {
            imgArrow.image = UIImage(named:"imgUpArrow")
        } else {
            imgArrow.image = UIImage(named:"imgDownArrow")
        }
        imgArrow.contentMode = .scaleAspectFit
        viewDownArrow.addSubview(imgArrow)
        
        //Tap Event
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didSelectSection(_:)))
        viewSection.addGestureRecognizer(tapGesture)
        
        //Title
        let lblTitle = UILabel.init(frame: CGRect(x: 15, y: 0, width: viewSection.frame.size.width-70, height: viewSection.frame.size.height))
        lblTitle.textAlignment = .left
        lblTitle.backgroundColor = .clear
        lblTitle.font = UIFont.boldSystemFont(ofSize: 14.0)
        lblTitle.textColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        lblTitle.text = self.arrHelp[section].strTitle
        lblTitle.isUserInteractionEnabled = false
        viewSection.addSubview(lblTitle)
        
        return viewSection
    }
    @objc func didSelectSection(_ sender: UITapGestureRecognizer? = nil) {
        let v = sender?.view!
        guard let section = v?.tag else { return }
        
        //Expand Section
        self.expandSection(section: section)
    }
    func expandSection(section:Int) {
        if(section >= 0) {
            self.arrHelp[section].isExpandable = !self.arrHelp[section].isExpandable
            
            UIView.transition(with: self.tblHelpList, duration: 0.25, options: .transitionCrossDissolve, animations: {
              self.tblHelpList.reloadData()
            }) { (isFinish) in
                
            }
        }
    }
}
//MARK: - Tapped Event
extension HelpVC {
    
    @IBAction func tappedOnBack(_ sender: Any) {
        
        //Redirect To Back Screen
        self.redirectToBackScreen()
    }
}
//MARL: - Redirect To Next Screen
extension HelpVC {
    
    func redirectToBackScreen() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Cell Help List
class CellHelpList:UITableViewCell {
    
    @IBOutlet var lblDescription: UILabel!
}

//MARK: - Modal Help
class ModalHelpData:NSObject {

    var arrHelp = [ModalHelpDataObject]()
    var strTitle = ""
    var isExpandable = false
    
    override init() {
        
    }
    init(strTitle:String,arrHelp:[ModalHelpDataObject],isExpandable:Bool) {
        self.arrHelp = arrHelp
        self.strTitle = strTitle
    }
}
//TODO: - Modal Help Data Object
class ModalHelpDataObject:NSObject {

    var strDescription = ""
    
    override init() {
        self.strDescription = ""
    }
    init(strDescription:String) {
        self.strDescription = strDescription
    }
}



