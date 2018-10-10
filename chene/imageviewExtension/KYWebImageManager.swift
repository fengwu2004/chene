//
//  KYWebImageManager.swift
//  chene
//
//  Created by ky on 2018/10/9.
//  Copyright © 2018 yellfun. All rights reserved.
//

import Foundation
import UIKit

struct KYWebImageManager {
  
  static let sharedInstance = KYWebImageManager()
  
  func queryImage(url:String, placehold:String, _ block:@escaping (UIImage) -> Void) -> Void {
    
    if url.isEmpty {
      
      if let img = KYWebImageCache.sharedInstance.query(url: placehold) {
        
        block(img)
      }
      else {
        
        if let img = UIImage(named: placehold) {
          
          KYWebImageCache.sharedInstance.doCache(key: url, image: img)
          
          block(img)
        }
      }
  
      return
    }
    
    if let image = KYWebImageCache.sharedInstance.query(url: url) {
      
      block(image)
      
      return
    }
    
    KYWebImageDownloader.sharedInstance.add(url) { (data) in
    
      if let data = data {
        
        if let img = UIImage.init(data: data) {
          
          KYWebImageCache.sharedInstance.doCache(key: url, image: img)
          
          block(img)
        }
      }
    }
  }
}
