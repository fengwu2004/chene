//
//  idrRegion.swift
//  chene
//
//  Created by ky on 2018/9/30.
//  Copyright © 2018 yellfun. All rights reserved.
//

import Foundation

struct IdrRegion {
  
  var Id = ""
  
  var name = ""
  
  var pinyin = ""
  
  var cityId = -1
  
  var photoUrl = ""
  
  var longitude = 0
  
  var latitude = 0
  
  var packingFee = 0
}

extension IdrRegion:ArrowParsable {
  
  mutating func deserialize(_ json:JSON) {
    
    Id <-- json["id"]
    
    name <-- json["name"]
    
    pinyin <-- json["pinyin"]
    
    cityId <-- json["cityId"]
    
    photoUrl <-- json["photoUrl"]
    
    longitude <-- json["longitude"]
    
    latitude <-- json["latitude"]
    
    packingFee <-- json["packingFee"]
  }
}
