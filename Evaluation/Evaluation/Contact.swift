//
//  Contact.swift
//  Evaluation
//
//  Created by Ricardo Batista on 9/21/16.
//  Copyright © 2016 XdroneStudio. All rights reserved.
//

import UIKit

class Contact {
  
  var name:String
  var image:UIImage?
  var isAdded = false
  
  init(withName name:String, imageName:String?){
    self.name = name
    if let imageName = imageName, image = UIImage(named: imageName) {
      self.image = image
    }
  }
  
}