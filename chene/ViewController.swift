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
        
        self.finishLoading = true
        
        self.tableview.reloadData()
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return 100
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if let cell = tableview.dequeueReusableCell(withIdentifier: "ParkingCell") as? ParkingCell {
      
      cell.refreshWithData(regions[indexPath.row])
      
      return cell
    }
    
    return ParkingCell()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if finishLoading == false {
      
      return 0
    }
    
    return regions.count
  }
}

