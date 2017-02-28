//
//  MenuViewController.swift
//  WinB
//
//  Created by karthikps on 25/01/17.
//  Copyright © 2017 karthikps. All rights reserved.
//

import UIKit

class MenuViewController: BaseViewController {

  @IBOutlet var collection: UICollectionView!
  @IBOutlet var cView: UIView!
  
  @IBOutlet var menuButton: UIButton!
  var popUp : UIButton! = nil
  var contents : [String] = [String]()
  var dict : [[String : String]] = [[String : String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
      self.viewTable.reloadData()
      let vc : BaseViewController = self.storyboard?.instantiateViewController(withIdentifier: "BaseViewController") as! BaseViewController
      
      self.addChildViewController(vc)
      
      self.cView.addSubview(vc.view)
      self.updateShadow(views: self.cView , viewColor: (self.cView.backgroundColor?.cgColor)!)
      vc.logoImg?.isHidden = false
      self.view.insertSubview(vc.sideView, aboveSubview: self.view)
      popUp  = UIButton(frame: CGRect(x: self.view.frame.size.width - 100 , y: self.view.frame.size.height - 110, width: 90, height: 90))
      popUp.addTarget(self, action: #selector(MenuViewController.popupAction), for: .touchUpInside)
      popUp.setBackgroundImage(UIImage(named:"ic_add-1"), for: .normal)
      self.view.addSubview(popUp)
      
      self.view.insertSubview(popUp, aboveSubview: self.view);
      let plistPath = Bundle.main.path(forResource: "MenuList", ofType: "plist")
      
      if let dict1 : [[String : String]]  = NSArray(contentsOfFile: plistPath!) as? [[String : String]] {
        
        dict = dict1
        print(dict)
        
        for x in 0..<dict.count {
          var temp = dict[x]
        contents.append(temp["TitleName"]!)
          
        }
        
      }
      
      //menuButton.addTarget(self, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
      
        // Do any additional setup after loading the view.
    }
  
  func popupAction(){
    
    
    
    let sView : UIImageView = UIImageView(frame: CGRect(x: self.popUp.frame.origin.x, y: self.popUp.frame.origin.y - 210, width: self.popUp.frame.size.width, height: 200))
    sView.image = UIImage(named: "Group 226")
    self.view.addSubview(sView)
    
    
  }
  
  @IBOutlet var viewTable: UITableView!
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell : MenutableCell = tableView.dequeueReusableCell(withIdentifier: "MenutableCell") as! MenutableCell
    var tempText : String = ""
    var tempCount = 0
    if indexPath.row == 0{
      tempText = "Pending Archive"
      tempCount = 10
    }
    else if indexPath.row == 1{
      tempText = "New contact in your territory"
      tempCount = 20
    }
    else if indexPath.row == 2{
      tempText = "New Deals"
      tempCount = 03
    }
    else {
      tempText = "Approval Pending"
      tempCount = 10
      
    }
    cell.tableText.text = tempText
    cell.tableCount.text = "\(tempCount)"
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return 4
    
  }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class MenutableCell : UITableViewCell{
  
  @IBOutlet var tableText: UILabel!
  
  @IBOutlet var tableCount: UILabel!
  
}

extension MenuViewController : UICollectionViewDataSource , UICollectionViewDelegate {

    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell : menuCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! menuCell
    var temp = dict[indexPath.row]
    let tempImage : UIImage = UIImage(named: temp["UnSelectedImage"]!)!
    cell.img.image = tempImage
    cell.menuLabel.text = "\(contents[indexPath.row])"
    //cell.backgroundColor = UIColor.blue
    
    return cell
    
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return contents.count
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    var vc : UIViewController!
    
    if indexPath.row == 1 {
      
      vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
      
      self.navigationController?.pushViewController(vc, animated: false)
      
    }
    
  }
  
  }


class menuCell : UICollectionViewCell  {
  
  @IBOutlet var menuAction: UIButton!
  @IBOutlet var menuLabel: UILabel!
  @IBOutlet var wholeView: UIView!
  @IBOutlet var img: UIImageView!
    
}
