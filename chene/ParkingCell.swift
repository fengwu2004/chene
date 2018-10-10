//
//  ParkingCell.swift
//  chene
//
//  Created by ky on 2018/9/30.
//  Copyright © 2018 yellfun. All rights reserved.
//

import UIKit

class ParkingCell: UITableViewCell {
  
  @IBOutlet private weak var countLabel:UILabel!
  
  @IBOutlet private weak var moneyLabel:UILabel!
  
  @IBOutlet private weak var distanceLabel:UILabel!
  
  @IBOutlet private weak var regionIcon:UIImageView!
  
  override func awakeFromNib() {
    
    super.awakeFromNib()
  }
  
  func refreshWithData(_ region:IdrRegion) {
    
    countLabel.text = "\(0)"
    
    moneyLabel.text = "\(0)"
    
    distanceLabel.text = "\(1000)km"
    
    regionIcon.set_urlImage(region.photoUrl, placeholder:"defaultreigonicon")    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    
    super.setSelected(selected, animated: animated)
  }
  
}
