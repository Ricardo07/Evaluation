//
//  HeaderSectionVIew.swift
//  Evaluation
//
//  Created by Ricardo Batista on 9/22/16.
//  Copyright © 2016 XdroneStudio. All rights reserved.
//

import UIKit

class HeaderSectionView: UIView {

  @IBOutlet var view: UIView!
  @IBOutlet weak var headerIconImage: UIImageView!
  @IBOutlet weak var headerLabel: UILabel!
  @IBOutlet weak var headerConnectedImage: UIImageView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInitialization()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInitialization()
  }
  
  func commonInitialization(){
    NSBundle.mainBundle().loadNibNamed("HeaderSectionView", owner: self, options: nil)
    self.bounds = view.bounds
    self.addSubview(view)
  }
}