//
//  ContactCell.swift
//  Evaluation
//
//  Created by Ricardo Batista on 9/25/16.
//  Copyright © 2016 XdroneStudio. All rights reserved.
//

import UIKit

protocol ContactCellDelegate {
  func didAddContactAtIndexpath(indexPath: NSIndexPath)
}

class ContactCell: UITableViewCell {
  
  @IBOutlet weak var contactImageView: UIImageView!
  @IBOutlet weak var contactNameLabel: UILabel!
  @IBOutlet weak var contactAddButton: UIButton!
  
  var delegate: ContactCellDelegate? = nil
  var indexPath: NSIndexPath? = nil
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  @IBAction func addContact(sender: UIButton) {
    if let delegate = delegate, indexPath = indexPath {
      delegate.didAddContactAtIndexpath(indexPath)
    }
  }
}
