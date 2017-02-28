//
//  AccountsViewController.swift
//  WinB
//
//  Created by karthikps on 21/02/17.
//  Copyright © 2017 karthikps. All rights reserved.
//

import UIKit

class AccountsViewController: BaseViewController {
  @IBOutlet var cView: UIView!
  @IBOutlet var aTableView: UITableView!
  var addMore : Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
      
      let vc : BaseViewController = self.storyboard?.instantiateViewController(withIdentifier: "BaseViewController") as! BaseViewController
      
      self.addChildViewController(vc)
      
      self.cView.addSubview(vc.view)
      self.updateShadow(views: self.cView , viewColor: (self.cView.backgroundColor?.cgColor)!)
      vc.addButton.isHidden = false
      self.view.insertSubview(vc.sideView, aboveSubview: self.view)
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if addMore == true {
      return 10
    }
      return accountsDict.count
    
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    if addMore == false {
      return 0
    }
    return 100
  }
  
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    
    let footerView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.aTableView.frame.size.width, height: 100))
    
    let moreButton : UIButton = UIButton(frame: CGRect(x: self.aTableView.frame.size.width - 120, y: 05, width: 80, height: 80))
    moreButton.setBackgroundImage(UIImage(named: "ic_add-1"), for: .normal)
    moreButton.addTarget(self, action: #selector(AccountsViewController.refreshPage), for: .touchUpInside)
    footerView.addSubview(moreButton)
    
    return footerView
    
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell : AccountsCell = tableView.dequeueReusableCell(withIdentifier: "AccountsCell") as! AccountsCell
    let temp : [String : String] = accountsDict[indexPath.row]
    cell.aTitle.text = temp["TitleText"]
    cell.aTextField.placeholder = temp["PlaceholderText"]

    return cell
    
  }
  
  func refreshPage(){
    
    addMore = false
    self.aTableView.reloadData()
    
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

class AccountsCell : UITableViewCell {
  
  @IBOutlet var aTextField: UITextField!
  @IBOutlet var aTitle: UILabel!
  
  @IBOutlet var aButton: DropMenuButton!
  
}
