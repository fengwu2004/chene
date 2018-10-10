//
//  KYWebImageCache.swift
//  chene
//
//  Created by ky on 2018/10/9.
//  Copyright © 2018 yellfun. All rights reserved.
//

import Foundation
import UIKit

class KYWebImageCache {

  static let sharedInstance = KYWebImageCache()
  
  private var cached = [String:UIImage]()
  
  func doCache(key url:String, image:UIImage) -> Void {
    
    objc_sync_enter(self)
    
    defer { objc_sync_exit(self) }
    
    cached[url] = image
  }
  
  func query(url:String) -> UIImage? {
    
    return cached[url]
  }
}
