//
//  HeaderSectionVIew.swift
//  Evaluation
//
//  Created by Ricardo Batista on 9/22/16.
//  Copyright © 2016 XdroneStudio. All rights reserved.
//

import UIKit

protocol ContactHeaderSectionViewDelegate {
  func didColapseSectionAt(section: Int)
}


class HeaderSectionView: UIView {

  @IBOutlet var view: UIView!
  @IBOutlet weak var headerIconImage: UIImageView!
  @IBOutlet weak var headerLabel: UILabel!
  @IBOutlet weak var headerConnectedButton: UIButton!
  
  var delegate:ContactHeaderSectionViewDelegate? = nil
  var section: Int = -1
  
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
  
  @IBAction func CollapseSection(sender: UIButton) {
    if let delegate = delegate where section >= 0 {
      delegate.didColapseSectionAt(section)
    }
  }
}