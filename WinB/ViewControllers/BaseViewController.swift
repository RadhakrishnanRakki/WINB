//
//  BaseViewController.swift
//  WinB
//
//  Created by karthikps on 25/01/17.
//  Copyright © 2017 karthikps. All rights reserved.
//

import UIKit
import Alamofire

class BaseViewController: UIViewController , manageData {

  @IBOutlet var sideTableView: UITableView!
  @IBOutlet var sideView: UIView!
  var content : [String] = [String]()
  var menuDict : [[String : String]] = [[String : String]]()
  var accountsDict : [[String : String]] = [[String : String]]()
  var imgContent : [String] = [String]()
  
  @IBOutlet var addButton: UIButton!
  
  @IBOutlet var logoImg: UIImageView?
  @IBOutlet var titleName: UILabel?
   let reachability = Reachability()!
    override func viewDidLoad() {
        super.viewDidLoad()
      self.logoImg?.isHidden = true
      self.titleName?.isHidden = true
      self.addButton?.isHidden = true
      
      let menu = Bundle.main.path(forResource: "List", ofType: "plist")
      
      if let dict = NSArray(contentsOfFile: menu!) as? [[String : String]] {
        
        menuDict = dict
        
        for x in 0..<dict.count {
          var temp = dict[x]
          content.append(temp["TitleName"]!)
          
        }
      }
      
      let accounts = Bundle.main.path(forResource: "Accounts", ofType: "plist")
      
      if let dict = NSArray(contentsOfFile: accounts!){
        
        accountsDict = dict as! [[String : String]]
        
      }
        
        // Do any additional setup after loading the view.
    }
  

  @IBAction func addAcc(_ sender: Any) {
    
    let vc : AccountsViewController = self.storyboard?.instantiateViewController(withIdentifier: "AccountsViewController") as! AccountsViewController
    self.navigationController?.pushViewController(vc, animated: true)
    
  }
  
  func updateShadow(views : UIView , viewColor : CGColor){
    
    views.layer.shadowColor = viewColor
    views.layer.shadowOpacity = 1.0
    views.layer.shadowRadius = 10.0
    
  }
  
  func pushResponse(response: DataResponse<Any>) {
    
    print(response)
    
  }

  @IBAction func baseInView(_ sender: UIButton) {
    
    UIView.animate(withDuration: 0.6, delay: 0.0, options: .curveEaseOut, animations: {
      
      let parentView : UIViewController = self.parent!
      var parentRect : CGRect = self.view.frame

      var siderect : CGRect = self.sideView.frame
      
      if siderect.origin.x == 0{
        
        siderect.origin.x = -600
        parentRect.origin.x = 0
        
      }
      else {
        
        siderect.origin.x = 0
        parentRect.origin.x = parentRect.origin.x + siderect.size.width
        
      }
      
      //self.sideView.frame = siderect
      self.sideView.frame = siderect
      //parentView.view.frame = parentRect
      
    }) { (finsished) in
      
      
      
    }
    
    //      let parentView : UIViewController = self.parent!
    //      var parentRect : CGRect = self.view.frame
    //      let siderect : CGRect = self.sideView.frame
    //
    //      if parentView.view.frame.origin.x == 0{
    //
    //        parentRect.origin.x = siderect.size.width + parentRect.origin.x
    //
    //      }
    //      else {
    //
    //        parentRect.origin.x = 0
    //
    //      }
    //
    //      parentView.view.frame = parentRect
    //
    //    }) { (finsished) in
    //      
    //      
    //      
    //    }
    
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

extension BaseViewController : UITableViewDelegate , UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    var vc : UIViewController = UIViewController()
    if indexPath.row == 0{
      
      vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountsMenuViewController") as! AccountsMenuViewController
      self.navigationController?.pushViewController(vc, animated: true)
      
    }
    else if indexPath.row == content.count - 1 {
      
            MBProgressHUD.showAdded(to: self.view, animated: true)
            DataManager.shared.fetchData(parameter: [:], method: .post, headers: [:], coding: true, urlStr: winB.logout)

    }
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return content.count
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell : sidemenuCell = tableView.dequeueReusableCell(withIdentifier: "sidemenuCell") as! sidemenuCell
    var temp = menuDict[indexPath.row]
    cell.textV.text = "\(content[indexPath.row])"
    cell.img.image = UIImage(named: "\(temp["UnSelectedImage"]!)")
    cell.backgroundColor = UIColor.clear
    
    return cell
    
  }
  
}

class sidemenuCell : UITableViewCell {
  
  @IBOutlet var img: UIImageView!
  @IBOutlet var textV: UILabel!
  
}


