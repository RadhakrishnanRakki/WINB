//
//  ContactsProfileViewController.swift
//  WinB
//
//  Created by karthikps on 13/02/17.
//  Copyright © 2017 karthikps. All rights reserved.
//

import UIKit
import MXParallaxHeader

class ContactsProfileViewController: BaseViewController {
  
  @IBOutlet var pTableView: UITableView!
  @IBOutlet var profileCell: UICollectionView!
  @IBOutlet var contactImage: UIImageView!
    //var scrollView: MXScrollView!
  var cellContent = ["BASIC INFO" , "ACTIVITIES" , "TASKS" , "APPOINTMENTS"]
  var popUp : UIButton! = nil
  
  @IBOutlet var scrollView: MXScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      popUp  = UIButton(frame: CGRect(x: self.view.frame.size.width - 100 , y: self.view.frame.size.height - 110, width: 90, height: 90))
      popUp.addTarget(self, action: #selector(ContactsProfileViewController.popupAction), for: .touchUpInside)
      popUp.setBackgroundImage(UIImage(named:"ic_add-1"), for: .normal)
      self.view.addSubview(popUp)
      
      self.view.insertSubview(popUp, aboveSubview: self.view);
      // Parallax Header
      //scrollView = MXScrollView()
//      scrollView.parallaxHeader.view = Bundle.main.loadNibNamed("StarshipHeader", owner: self, options: nil)?.first as? UIView // You can set the parallax header view from a nib.
//      scrollView.parallaxHeader.height = 122
//      scrollView.parallaxHeader.mode = MXParallaxHeaderMode.fill
      
      //scrollView.addSubview(contactImage)
      //scrollView.parallaxHeader.minimumHeight = 20
      //view.addSubview(scrollView)
        // Do any additional setup after loading the view.
      
    }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }
  
  var indexCount = 100
  override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return cellContent.count
    
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell : contactsTableCell = tableView.dequeueReusableCell(withIdentifier: "contactsTableCell") as! contactsTableCell
    cell.name.text = "Name no :- \(indexPath.row)"
    cell.subName.text = "SubName no :- \(indexPath.row)"
    return cell
    
  }
  
  func popupAction(){

    let sView : UIImageView = UIImageView(frame: CGRect(x: self.popUp.frame.origin.x, y: self.popUp.frame.origin.y - 210, width: self.popUp.frame.size.width, height: 200))
    sView.image = UIImage(named: "Group 226")
    self.view.addSubview(sView)

  }
  
  @IBAction func backAction(_ sender: Any) {
    
    self.navigationController?.popViewController(animated: false)
    
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

extension ContactsProfileViewController : UICollectionViewDelegate , UICollectionViewDataSource  {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return cellContent.count
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    indexCount = indexPath.row
    self.profileCell.reloadData()
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell : contactsProfileCell = collectionView.dequeueReusableCell(withReuseIdentifier: "contactsProfileCell", for: indexPath) as! contactsProfileCell
    
    cell.cellImage.isHidden = true
    cell.cellTitle.text = "\(cellContent[indexPath.row])"
    cell.cellTitle.textColor = UIColor.gray
    if indexPath.row == indexCount{
      indexCount = 100
      cell.cellImage.isHidden = false
      cell.cellImage.backgroundColor = UIColor.orange
      cell.cellTitle.textColor = UIColor.orange
      
    }
    
    return cell
    
  }
  
}

class contactsTableCell : UITableViewCell {
  
  @IBOutlet var name: UILabel!
  @IBOutlet var subName: UILabel!
  
  
}

class contactsProfileCell : UICollectionViewCell {
  
  
  @IBOutlet var cellTitle: UILabel!
  
  @IBOutlet var cellImage: UIImageView!
  
  
}
