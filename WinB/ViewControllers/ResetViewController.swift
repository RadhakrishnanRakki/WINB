//
//  ResetViewController.swift
//  WinB
//
//  Created by karthikps on 25/01/17.
//  Copyright © 2017 karthikps. All rights reserved.
//

import UIKit
import Alamofire

class ResetViewController: UIViewController , manageData {

  @IBOutlet var otpText: UITextField!
  @IBOutlet var password: UITextField!
  @IBOutlet var reEnterPasswprd: UITextField!
  var emailToken : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
      DataManager.shared.delegate = self
      otpText.attributedPlaceholder = NSAttributedString(string: "OTP", attributes: [NSForegroundColorAttributeName : UIColor.lightText])
      password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName : UIColor.lightText])
      reEnterPasswprd.attributedPlaceholder = NSAttributedString(string: "Re-Enter Password", attributes: [NSForegroundColorAttributeName : UIColor.lightText])
      
      let parameters : Parameters = ["email" : "karthik.p@tvsnext.io"]
//      MBProgressHUD.showAdded(to: self.view, animated: true)
//      DataManager.shared.fetchData(parameter: parameters, method: .post, headers: [:], coding: true, urlStr: winB.forget)
      
        // Do any additional setup after loading the view.
    }
  
  func pushResponse(response: DataResponse<Any>) {
    
    print(response)
    MBProgressHUD.hide(for: self.view, animated: true)
    print(response.request as Any)
    if response.response?.statusCode == 200{
      
      print("SUCCESS")
      print(response)
      
    }
    else {
      
      print("FAILURE " , response.response?.statusCode as Any)
      
    }
    
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func resetAction(_ sender: Any) {
    
    let parameters : Parameters = ["username": "\(emailToken)" , "password":"\(password.text!)"]
    MBProgressHUD.showAdded(to: self.view, animated: true)
    DataManager.shared.fetchData(parameter: parameters, method: .post, headers: [:], coding: true, urlStr: winB.reset)
    
    
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

extension ResetViewController : UITextFieldDelegate {
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    
    
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    textField.resignFirstResponder()
    return true
    
  }
  
}
