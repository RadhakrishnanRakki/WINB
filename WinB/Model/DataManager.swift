//
//  DataManager.swift
//  WinB
//
//  Created by karthikps on 31/01/17.
//  Copyright © 2017 karthikps. All rights reserved.
//

import UIKit
import Alamofire

struct winB {
  
  static let signin = "https://winb.tvsnext.io/testing/mobapi/index.php/site/signin"
  static let reset = "https://winb.tvsnext.io/testing/mobapi/index.php/site/resetpassword"
  static let forget = "https://winb.tvsnext.io/testing/mobapi/index.php/site/forgorpassword"
  static let logout = "https://winb.tvsnext.io/testing/mobapi/index.php/site/signout"
  static let param : [String : Any] = ["userdetails" : [
    "UserID":"",
    "DeviceID":"\(UIDevice.current.identifierForVendor?.uuidString)",
    "EmailID":"karthik@k.com",
    "Password":"12345",
    "IsSignedwithSocialMedia":"",
    "IsMailSent":"",
    "MailSentOn":"12/12/2000",
    "CreatedOnMobile":"12/12/2000",
    "CreatedLat":"",
    "CreatedLang":"",
    "IsAutoLogOn":"12/12/2000",
    "ActivationCode":"",
    "IsActivated":"",
    "DeleteCode":"",
    "IsDeleted":"",
    "UpdatedOnMobile":"12/12/2000",
    "UpdatedOn":"12/12/2000",
    "UpdatedLat":"",
    "UpdatedLang":"",
    "MobileRowOrderNo":""
    ]]
  
}

struct user {
  
   var data : [String : AnyObject] = [String : AnyObject]()
  var Active : String = ""
  var CB : String = String()
  var CD : String = String()
  var Email : String = String()
  var FullName : String = String()
  var JobTitle : String = String()
  var LastLogin : String = String()
  var MB : String = String()
  var MD : String = String()
  var ManagerID : String = String()
  var MobilePhone : String = String()
  var Password : String = String()
  var Photo : String = String()
  var Salt : String = String()
  var Scope : String = String()
  var TimeZone : String = String()
  var U_ID : String = String()
  var WorkPhone : String = String()
  var Role : [String : AnyObject] = [String : AnyObject]()
  
  init(json : [String : AnyObject]) {
    
    data = json
    /*{
     data =     {
     Active = 1;
     CB = "<null>";
     CD = "01/01/1970 00:00:00";
     Email = "aditya@tvsnext.io";
     FullName = Aditya;
     JobTitle = "Product Manager";
     LastLogin = "<null>";
     MB = "<null>";
     MD = "27/01/2017 15:18:49";
     ManagerID = "<null>";
     MobilePhone = 9962116799;
     Password = 3d5e9beb72546903425abd4726656b2637dc94a9;
     Photo = "<null>";
     Role =         {
     AD = 1;
     M = 1;
     };
     Salt = 727;
     Scope = G;
     TimeZone = 13;
     "U_ID" = 29;
     WorkPhone = 9962116799;
     };
     success = 1;
     })*/
    Active = checkNil(str: "Active" , check: false) as! String
    CB = checkNil(str: "CB" , check: false) as! String
    CD = checkNil(str: "CD" , check: false) as! String
    Email = checkNil(str: "Email" , check: false) as! String
    FullName = checkNil(str: "FullName" , check: false) as! String
    JobTitle = checkNil(str: "JobTitle" , check: false) as! String
    LastLogin = checkNil(str: "LastLogin" , check: false) as! String
    MB = checkNil(str: "MB" , check: false) as! String
    MD = checkNil(str: "MD" , check: false) as! String
    ManagerID = checkNil(str: "ManagerID" , check: false) as! String
    MobilePhone = checkNil(str: "MobilePhone" , check: false) as! String
    Password = checkNil(str: "Password" , check: false) as! String
    Photo = checkNil(str: "Photo" , check: false) as! String
    Salt = checkNil(str: "Salt" , check: false) as! String
    Scope = checkNil(str: "Scope" , check: false) as! String
    TimeZone = checkNil(str: "TimeZone" , check: false) as! String
    U_ID = "\(Int(checkNil(str: "U_ID" , check: false) as! String))"
    WorkPhone = checkNil(str: "WorkPhone" , check: false) as! String
    Role = checkNil(str: "Role" , check: true) as! [String : AnyObject]
    
  }
  
  func checkNil(str : String , check : Bool) -> Any{
    
    print("str is " , str)
    if data["\(str)"] is NSNull{
      
    return ""
    }
    print(data["\(str)"] as Any)
    if check == true{
      
      return data["\(str)"] as! [String : AnyObject]
      
    }
    
    if data["\(str)"] is String{
      
      return data["\(str)"] as! String
      
    }
    else {
      
      let temp = data["\(str)"]
      return "\(temp!)"
      
    }
    
    return data["\(str)"] as Any
    
  }
  
  func updateDict() -> [String : AnyObject]{
    
    DataManager.shared.userValue = self
    return self.data
    
  }
  
}

protocol manageData {
  
  func pushResponse(response : DataResponse<Any>)
  
}

class DataManager: NSObject {

  static let shared = DataManager()
  
  var userValue : user!
  
  var delegate : manageData?
  
  func fetchData(parameter : Parameters , method : HTTPMethod , headers : HTTPHeaders , coding : Bool , urlStr : String){
    
    Alamofire.request(urlStr, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
      
      print(response.request as Any)
      print(response.response as Any)
      print(response.response?.statusCode as Any)
      
      if response.response?.statusCode == 200 {
        
        print("Success")
        self.delegate?.pushResponse(response: response)
        
      }
      else{
        
        print("Failure")
        self.delegate?.pushResponse(response: response)
      }
      
    }

    
    
  }
  
  
}
