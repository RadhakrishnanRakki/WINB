//
//  AccountsMenuViewController.swift
//  WinB
//
//  Created by karthikps on 22/02/17.
//  Copyright © 2017 karthikps. All rights reserved.
//

import UIKit

class AccountsMenuViewController: BaseViewController {
  
  @IBOutlet var topView: UIView!
  @IBOutlet var cView: UIView!

  

    override func viewDidLoad() {
        super.viewDidLoad()
      
      let vc : BaseViewController = self.storyboard?.instantiateViewController(withIdentifier: "BaseViewController") as! BaseViewController
      
      self.addChildViewController(vc)
      self.cView.addSubview(vc.view)
      vc.addButton?.isHidden = false
      self.updateShadow(views: self.cView , viewColor: (self.cView.backgroundColor?.cgColor)!)
      //self.updateShadow(views: self.topView , viewColor: (self.cView.backgroundColor?.cgColor)!)
      
      self.view.insertSubview(vc.sideView, aboveSubview: self.view)
        // Do any additional setup after loading the view.
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
