//
//  ParkingCell.swift
//  chene
//
//  Created by ky on 2018/9/30.
//  Copyright © 2018 yellfun. All rights reserved.
//

import UIKit

class ParkingCell: UITableViewCell {
  
  @IBOutlet weak var countLabel:UILabel!
  
  @IBOutlet weak var moneyLabel:UILabel!
  
  @IBOutlet weak var distanceLabel:UILabel!
  
  @IBOutlet weak var regionIcon:UIImageView!
  
  override func awakeFromNib() {
    
    super.awakeFromNib()
  }
  
  func refreshWithData(_ region:IdrRegion) {
    
    countLabel.text = "\(0)"
    
    moneyLabel.text = "\(0)"
    
    distanceLabel.text = "\(1000)km"
    
    regionIcon.image = UIImage()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    
    super.setSelected(selected, animated: animated)
  }
  
}
