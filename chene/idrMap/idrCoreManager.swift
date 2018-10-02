//
//  idrCoreManager.swift
//  chene
//
//  Created by ky on 2018/9/30.
//  Copyright © 2018 yellfun. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class idrCoreManager {
  
  static let sharedInstance = idrCoreManager()
  
  private var appid = "2b497ada3b2711e4b60500163e0e2e6b"
  
  private var appkey = "3d256f0e0ebd51f6176358abd62c1ae0"
  
  private var appBundleId = "com.Yellfun.Cars"
  
  private var phoneuuid:String?
  
  private var sessionKey:String?
  
  var regions:[Any]?
  
  func initRegions() -> Promise<[Any]?> {
    
    return Promise(callback: { (resovle, _) in
      
      self.initSession()
        .then { (sessionKey) -> Promise<[Any]?> in
          
          self.sessionKey = sessionKey
          
          return self.loadAllRegion()
      }
        .then({ regions in
          
          self.regions = regions
          
          resovle(regions)
        })
    })
  }
  
  func initSession() -> Promise<String?> {
    
    self.phoneuuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    
    let paras = retrivereqdata()
    
    return Promise(callback: { resolve, _ in
      
      Alamofire.request("https://interface.indoorun.com/ck/initAppSession.html?\(paras)")
        .responseJSON { response in
          
          if let json = response.result.value {
            
            if let code = (json as? [String:Any])?["code"] as? String {
              
              if code == "success" {
                
                resolve((json as? [String:Any])?["sessionKey"] as? String)
                
                return
              }
            }
          }
      }
    })
  }
  
  func loadAllRegion() -> Promise<[Any]?> {
    
    let appiduuidsession = "appId=\(self.appid)&phoneUUID=\(self.phoneuuid!)&sessionKey=\(self.sessionKey!)"
    
    let url = "https://interface.indoorun.com/ck/getRegionsOfUser.html?\(appiduuidsession)"
    
    return Promise() { resolve, _ in
      
      Alamofire.request(url)
        .responseJSON { response in
          
          if let json = response.result.value {
            
            if let jsondata = json as? [String:Any] {
              
              if let code = jsondata["code"] as? String {
                
                if code == "success" {
                  
                  resolve(jsondata["data"] as? [Any])
                }
              }
            }
          }
      }
    }
  }
  
  func retrivereqdata() -> String {
    
    let appid = "appId=\(self.appid)"
    
    let osType = "OSType=iOS"
    
    let appPkgName = "appPkgName=\(self.appBundleId)"
    
    let phoneUUID = "phoneUUID=\(self.phoneuuid!)"
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "yyyyMMddHHmmss"
    
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0800")
    
    let date = dateFormatter.string(from: Date())
    
    let time = "time=\(date)"
    
    let appKey = "appKey=\(self.appkey)"
    
    let postParm = "\(appid)&\(osType)&\(appPkgName)&\(phoneUUID)&\(time)&\(appKey)"
    
    print(postParm)
    
    let md5 = MD5(postParm).lowercased()
    
    print(md5)
    
    return postParm + "&sign=\(md5)"
  }
}
