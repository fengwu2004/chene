//
//  UIImageView+urlfile.swift
//  chene
//
//  Created by ky on 2018/10/9.
//  Copyright © 2018 yellfun. All rights reserved.
//

import Foundation
import UIKit

private var AssociatedObjectHandle: UInt8 = 0

extension UIImageView {
  
  func set_urlImage(_ url:String, placeholder:String) -> Void {
    
    objc_setAssociatedObject(self, &AssociatedObjectHandle, url, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
    
    KYWebImageManager.sharedInstance.queryImage(url: url, placehold: placeholder) { (image) in
      
      DispatchQueue.main.async {
        
        if let _url = objc_getAssociatedObject(self, &AssociatedObjectHandle) as? String {
          
          if _url == url {
         
            self.image = image
          }
        }
      }
    }
  }
}
