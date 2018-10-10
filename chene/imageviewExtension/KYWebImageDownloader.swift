//
//  KYImageDownloader.swift
//  chene
//
//  Created by ky on 2018/10/9.
//  Copyright © 2018 yellfun. All rights reserved.
//

import Foundation

class KYDownloaderTask {
  
  typealias TaskType = ()->Void
  
  var priority = 0
  
  var task:TaskType?
  
  init(_ task:@escaping TaskType) {
    
    self.task = task
  }
  
  func start() -> Void {
    
    if let task = self.task {
      
      task()
    }
  }
}

extension KYDownloaderTask: Comparable {
  
  static func < (lhs:KYDownloaderTask, rhs:KYDownloaderTask) -> Bool {
    
    return lhs.priority > rhs.priority
  }
  
  static func == (lhs:KYDownloaderTask, rhs:KYDownloaderTask) -> Bool {
    
    return lhs.priority == rhs.priority
  }
}

class KYWebImageDownloader {
  
  static let sharedInstance = KYWebImageDownloader()
  
  private let runqueue = DispatchQueue(label: "KYDownloadQueue")
  
  private let taskQueue:KYPriorityQueue = KYPriorityQueue<KYDownloaderTask>(KYDownloaderTask({}))
  
  private var semaphore = DispatchSemaphore(value: 3)
  
  private var queueSemaphore = DispatchSemaphore(value: 0)
  
  private var runningTaskCount = 0
  
  init() {
    
    self.checkrun()
  }
  
  func checkrun() -> Void {
    
    runqueue.async {
      
      while true {
        
        self.queueSemaphore.wait()
        
        while let task = self.taskQueue.findMin() {
          
          self.semaphore.wait()
          
          task.start()
          
          self.taskQueue.deleteMin()
        }
      }
    }
  }
  
  func add(_ urlstr:String, complete:@escaping (Data?)->Void) -> Void {
    
    let task = KYDownloaderTask {
      
      if let url = URL(string: urlstr) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          
          print(url)
          
          self.semaphore.signal()
          
          if error == nil {
            
            complete(data)
          }
          else {
            
            print("失败" + urlstr)
          }
        }.resume()
      }
    }
    
    if let t = taskQueue.findMin() {
      
      task.priority = t.priority + 1
    }
    
    taskQueue.insert(task)
    
    queueSemaphore.signal()
  }
}
