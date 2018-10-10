//
//  ViewController.swift
//  chene
//
//  Created by ky on 2018/9/29.
//  Copyright © 2018 yellfun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableview:UITableView!
  
  private var regions:[IdrRegion]!
  
  private var finishLoading = false

  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    tableview.register(UINib(nibName: "ParkingCell", bundle: nil), forCellReuseIdentifier: "ParkingCell")
    
    idrCoreManager.sharedInstance.initRegions()
      .then { (regions) in
        
        self.regions = regions?.map { return IdrRegion(JSON($0)) ?? IdrRegion() }
        
        self.regions = self.regions.filter({ (region) -> Bool in
          
          return !region.photoUrl.isEmpty
        })
        
        self.finishLoading = true
        
        self.tableview.reloadData()        
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

    if section == 0 {
      
      return 0.001
    }
    
    return 10
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

    return 0.001
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return 209
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    print(indexPath.section)
    
    if let cell = tableview.dequeueReusableCell(withIdentifier: "ParkingCell") as? ParkingCell {
      
      cell.refreshWithData(regions[indexPath.section])
      
      return cell
    }
    
    return ParkingCell()
  }
  
  func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
    
    return false
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return 1
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    
    guard finishLoading else {
      
      return 0
    }
    
    return regions.count
  }
}

