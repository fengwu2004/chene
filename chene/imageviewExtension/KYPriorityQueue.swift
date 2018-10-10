//
//  KYPriorityQueue.swift
//  chene
//
//  Created by ky on 2018/10/10.
//  Copyright © 2018 yellfun. All rights reserved.
//

import Foundation

class KYPriorityQueue<T:Comparable> {
  
  var array:[T]
  
  var currentSize = 0
  
  init(_ initValue:T) {
    
    array = Array<T>()
    
    array.append(initValue)
  }
  
  func display() -> Void {
    
    print(array)
  }
  
  func findMin() -> T? {
    
    guard currentSize > 1 else {
      
      return nil
    }
    
    return array[1]
  }
  
  func resizeAndAppend(_ value:T) -> Void {
    
    let old = array
    
    array = Array()
    
    for i in 0..<currentSize {
      
      array.append(old[i])
    }
    
    array.append(value)
  }
  
  func insert(_ value:T) {
    
    currentSize += 1
    
    if array.count < currentSize + 1 {
      
      resizeAndAppend(value)
    }
    else {
      
      array[currentSize] = value
    }
    
    if currentSize <= 1 {
      
      return
    }
    
    var i = currentSize
    
    while i > 0 {
      
      let p = i / 2
      
      if array[i] < array[p] {
        
        return
      }
      
      array.swapAt(i, p)
      
      i = p
    }
  }
  
  func deleteMin() {
    
    array[1] = array[currentSize]
    
    currentSize -= 1
    
    var i = 1
    
    var child = 2 * i
    
    while child <= currentSize {
      
      if child != currentSize && array[child + 1] < array[child] {
        
        child += 1
      }
      
      if array[child] < array[i] {
        
        array.swapAt(child, i)
        
        i = child
      }
      else {
        
        break
      }
    }
  }
}
