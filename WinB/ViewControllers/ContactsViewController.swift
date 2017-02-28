//
//  ContactsViewController.swift
//  WinB
//
//  Created by karthikps on 13/02/17.
//  Copyright © 2017 karthikps. All rights reserved.
//

import UIKit

class ContactsViewController: BaseViewController {
  @IBOutlet var cView: UIView!
  
  @IBOutlet var cTableView: UITableView!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      let vc : BaseViewController = self.storyboard?.instantiateViewController(withIdentifier: "BaseViewController") as! BaseViewController
      
      self.addChildViewController(vc)
      
      self.cView.addSubview(vc.view)
      self.updateShadow(views: self.cView , viewColor: (self.cView.backgroundColor?.cgColor)!)
      self.view.insertSubview(vc.sideView, aboveSubview: self.view)

        // Do any additional setup after loading the view.
    }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return 3
    
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    var cell : contactsCell = tableView.dequeueReusableCell(withIdentifier: "contactsCell") as! contactsCell
    cell.contactName.text = "Name  \(indexPath.row)"
    cell.contactLabel.text = "SubTitle \(indexPath.row)"
    cell.contactsDays.text = "\(indexPath.row + 1) days to go"
    
    return cell
    
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let vc : ContactsProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContactsProfileViewController") as! ContactsProfileViewController
    
    self.navigationController?.pushViewController(vc, animated: true)
    
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

class contactsCell : UITableViewCell {
  
  @IBOutlet var contactDemo: UIButton!
  
  @IBOutlet var contactName: UILabel!
  
  @IBOutlet var contactLabel: UILabel!
  
  @IBOutlet var contactsDays: UILabel!
  
}
