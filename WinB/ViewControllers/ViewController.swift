//
//  ViewController.swift
//  WinB
//
//  Created by karthikps on 24/01/17.
//  Copyright © 2017 karthikps. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: BaseViewController  {

  @IBOutlet var passText: UITextField!
  @IBOutlet var emailText: UITextField!
  @IBOutlet var rememberCheck: UIButton!
  
  @IBOutlet var logoImage: UIImageView!
  let data = DataManager.shared
  
  var use = user.self
  override func viewDidLoad() {
    super.viewDidLoad()
    
    passText.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName : UIColor.lightText])
    emailText.attributedPlaceholder = NSAttributedString(string: "UserName", attributes: [NSForegroundColorAttributeName : UIColor.lightText])
    data.delegate = self
    emailText.text = "karthik.p@tvsnext.io"
    passText.text = "Karthik123@"

    let url = URL(string: "http://i.imgur.com/w5rkSIj.jpg")
    
    let datas = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
    self.logoImage.image = UIImage(data: datas!)
    let temp : [String : Any] = ["userdetails" : ["name" : "Karthik" , "surname" : "s" , "city" : "chennai"]]
    print(temp)
    
    print(Date().getCurrentDate())

    
    do {
      
      let jsonDict = try? JSONSerialization.data(withJSONObject: temp, options: .prettyPrinted)
      
      print(jsonDict?.description as Any)
      
    }
    
//    var req : URLRequest = URLRequest(url: URL(string: "https://prospero.uatproxy.cdlis.co.uk/prospero/DocumentUpload.ajax")!)
//    req.httpMethod = "POST"
//    let boudary = "Boundary-\(UUID().uuidString)"
//    req.setValue("multipart/form-data; boundary=\(boudary)", forHTTPHeaderField: "Content-Type")
//   /// req.httpBody = createBody(parameters: params,
//                            boundary: boudary,
//                            data: UIImageJPEGRepresentation(chosenImage, 0.7)!,
//                            mimeType: "image/jpg",
//                            filename: "hello.jpg")
    
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func createBody(parameters: [String: String],
                  boundary: String,
                  data: Data,
                  mimeType: String,
                  filename: String) -> Data {
    let body = NSMutableData()
    
    let boundaryPrefix = "--\(boundary)\r\n"
    
    for (key, value) in parameters {
      body.appendString(boundaryPrefix)
      body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
      body.appendString("\(value)\r\n")
    }
    
    body.appendString(boundaryPrefix)
    body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
    body.appendString("Content-Type: \(mimeType)\r\n\r\n")
    body.append(data)
    body.appendString("\r\n")
    body.appendString("--".appending(boundary.appending("--")))
    
    return body as Data
  }
  
  
  override func pushResponse(response: DataResponse<Any>) {
    
    MBProgressHUD.hide(for: self.view, animated: true)
    if response.response?.statusCode == 200{
      
      var json = response.result.value as! [String : AnyObject]
      print("SUCCESS")
      print(json)
      print(json["data"] as Any)
      let coordinates = user.init(json: json["data"] as! [String : AnyObject])
      print(coordinates.Active)
      
    }
    else {
      
      print("FAILURE " , response.response?.statusCode as Any)
      
    }
    
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath)
    cell.backgroundColor = UIColor.yellow
    return cell
    
    
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return 5
    
  }

  
  @IBAction func forgetPassword(_ sender: UIButton) {
    
    let vc : ResetViewController = self.storyboard?.instantiateViewController(withIdentifier: "ResetViewController") as! ResetViewController
    self.navigationController?.pushViewController(vc, animated: true)
    
  }
  
  @IBAction func rememberMe(_ sender: UIButton) {
    
    if sender.isSelected == true{
      sender.isSelected = false
      sender.setBackgroundImage(UIImage(named: "CheckBoxoff"), for: UIControlState.normal)
      
    }
    else{
      sender.isSelected = true
      sender.setBackgroundImage(UIImage(named: "CheckBox"), for: UIControlState.normal)
      
    }
    
  }
  
  @IBAction func loginAction(_ sender: Any) {
    
    if reachability.isReachable == true {
      MBProgressHUD.showAdded(to: self.view , animated: true)
    let parameters : Parameters = ["username" : "\(emailText.text!)" , "password" : "\(passText.text!)"]
    print(parameters)
    do{
      
    let jsonData  = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    
    print(jsonData)
      let strs = NSString(data : jsonData , encoding : String.Encoding.utf8.rawValue)
      print(strs! as Any)
      let str  = try JSONSerialization.jsonObject(with: jsonData, options: [])
      print(str)
      
      if let dictfromjson = strs?.data(using: String.Encoding.utf8.rawValue) {
        
        print(dictfromjson)

        do{
        let urls = winB.signin
        let url : URL = URL(string: urls)!
        var urlRequest : URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.httpBody = jsonData
          
          Alamofire.request(urlRequest).responseJSON{response in
            MBProgressHUD.hide(for: self.view, animated: true)
            print(response)
            print(response.request as Any)
            print(response.response as Any)
            print(response.result.value as Any)
            print(response.result.isSuccess as Any)
            var json = response.result.value as! [String : AnyObject]
            if let detail : Bool  = json["success"] as? Bool {

              if (detail == false) {
                
                if let data : String = json["data"] as? String{
                RKDropdownAlert.title("Alert", message: data)
                }
                
              }
              else{
                
                let coordinates = user.init(json: json["data"] as! [String : AnyObject])
                print("coordinates.data coordinates.data" , coordinates.data)
                let vc : MenuViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
                
                self.navigationController?.pushViewController(vc, animated: false)
                
              }
              
              
            }


            
          }
        
//          let ulrsession = URLSession.shared
//
//          let dataTask = ulrsession.dataTask(with: urlRequest){data,response,error in
//            
//            let httpResponse = response as? HTTPURLResponse
//            
//            if (error != nil) {
//              print(error as Any)
//            } else {
//              print(httpResponse as Any)
//              print(data as Any)
//              do{
//              let json = try? JSONSerialization.jsonObject(with: data!, options: [])
//              if let parseJson = json{
//                
//                print(parseJson)
//                
//              }
//              }
//              
//            }
//
//          }
//          dataTask.resume()
          
        
        
        }
        //MBProgressHUD.showAdded(to: self.view, animated: true)
        //DataManager.shared.fetchData(parameter: str as! Parameters, method: .post, headers: [:], coding: true, urlStr: winB.signin)
        
      }
      
    }catch{
      
    }
  }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}
extension NSMutableData {
  func appendString(_ string: String) {
    let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
    append(data!)
  }
}
extension Date {
  
  func getCurrentDate() -> String {
    
    
    let formatter : DateFormatter = DateFormatter()
    formatter.dateFormat = "dd/mm/yyyy"
    formatter.dateStyle = .short
    return formatter.string(from: self)
    
    
  }
  
  
}

extension ViewController : UITextFieldDelegate {
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    
    
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    textField.resignFirstResponder()
    return true
    
  }
  
}

