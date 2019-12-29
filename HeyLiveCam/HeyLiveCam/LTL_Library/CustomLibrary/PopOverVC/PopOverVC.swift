import UIKit

//MARK: - PopupOver Delegate
protocol PopupOverDelegate {
    
    func getPopOverData(arrData:[ModelPopupOver],index:Int,tag:Int)
    func dismissPopoverView()
}

//MARK: - Popup list cell
class CellPopupOver:UITableViewCell {

    @IBOutlet var imgSelectedSign: UIImageView!
    @IBOutlet var lblTitle: UILabel!
}

//MARK: - Model Class For Store List Data
class ModelPopupOver {
    
    var isSelected:Bool = false
    var isSelectionTouch:Bool = true
    var title:String = ""
    var id:String = ""
    
    init(isSelected:Bool
        ,title:String,
         id:String,
         isSelectionTouch:Bool) {
        
        self.isSelected = isSelected
        self.title = title
        self.id = id
        self.isSelectionTouch = isSelectionTouch
    }
    init(){
        
        self.isSelected = false
        self.title = ""
        self.id = ""
        self.isSelectionTouch = true
    }
}

//MARK: - Popover View Controller
class PopOverVC: UIViewController {

    //MARK: - Outlet declaration
    @IBOutlet var tblPopOverList: UITableView!
    
    //MARK: - Variable declaration
    var arrPopOverList = [ModelPopupOver]()
    var popupIndex = 0
    
    //Delegate
    var delegate:PopupOverDelegate?
    
    //View Controller override methods
    override func viewDidLoad() {
        super.viewDidLoad()

        //Initialization
        self.initialization()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tblPopOverList.reloadData()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.delegate?.dismissPopoverView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK: - Initialization
    func initialization() {
        
        //Cell size according to device
        self.tblPopOverList.rowHeight = UITableView.automaticDimension
        self.tblPopOverList.estimatedRowHeight = 44.0
        self.preferredContentSize = CGSize(width: self.preferredContentSize.width, height: CGFloat(arrPopOverList.count) * 44.0)
        
        tblPopOverList.reloadData()
    }
//MARK: - Hide Popover view controller
    func hidePopOverView(index:Int) {
    
        delegate?.getPopOverData(arrData: arrPopOverList, index: index,tag:popupIndex)
        self.dismiss(animated: true) {
            
        }
    }
}

//MARK: - UITableViewDelegate methods
extension PopOverVC:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (tblPopOverList == tableView) {
            
            if (arrPopOverList[indexPath.row].isSelectionTouch == true) {
             
                for index in 0..<arrPopOverList.count {
                    
                    arrPopOverList[index].isSelected = false
                }
                
                arrPopOverList[indexPath.row].isSelected = true
                tblPopOverList.reloadData()
                self.hidePopOverView(index: indexPath.row)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}
//MARK: - UITableViewDataSource methods
extension PopOverVC:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //List count
        return arrPopOverList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
         -> Don’t perform data binding at cellForItemAt method.
         -> B'coz because there’s no cell on screen yet.
         -> Just get the reuse cell from catch or create new and return immediately. this increase calling frequency of this method.
         -> For data binding you can use willDisplay method.
         */
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellPopupOver", for: indexPath) as! CellPopupOver
        
        //Hide and show selected cell
        if (self.arrPopOverList[indexPath.row].isSelected == true) {
            cell.imgSelectedSign.isHidden = true
            //btnPhoto.setTitleColor(UIColor.init(red: 254/255, green: 96/255, blue: 32/255, alpha: 1), for: .normal)
            cell.lblTitle.textColor = UIColor.init(red: 254/255, green: 96/255, blue: 32/255, alpha: 1)
        } else {
        
            cell.imgSelectedSign.isHidden = true
            cell.lblTitle.textColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        }
        
        //Set title data
        cell.lblTitle.text = arrPopOverList[indexPath.row].title
        
        return cell
    }
}
