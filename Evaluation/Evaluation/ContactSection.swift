//
//  ContactSection.swift
//  Evaluation
//
//  Created by Ricardo Batista on 9/21/16.
//  Copyright © 2016 XdroneStudio. All rights reserved.
//

import UIKit

class ContactSection {
  
  var contacts = [Contact]()
  var sectionName:String
  var image:UIImage?
  var isConnected:Bool = true
  
  init(withName name:String, imageName:String?) {
    self.sectionName = name
    if let imageName = imageName, image = UIImage(named: imageName) {
      self.image = image
    }
  }
  
  
  // MARK: - Helper Methods
  
  func filterContactsForSearchText(searchText: String) -> [Contact] {
    return contacts.filter({( contact : Contact) -> Bool in
      return contact.name.lowercaseString.containsString(searchText.lowercaseString)
    })
  }
  
  static func exampleStaticData() -> [ContactSection]{
    
    let addressBookContactSection = ContactSection(withName: "Address book contacts", imageName: "Contacts")
    
    addressBookContactSection.contacts.append(Contact(withName: "Lloyd Dotson", imageName: "Lloyd"))
    addressBookContactSection.contacts.append(Contact(withName: "Cathy Lyons", imageName: "Cathy"))
    addressBookContactSection.contacts.append(Contact(withName: "Leann Snyder", imageName: "Leann"))
    addressBookContactSection.contacts.append(Contact(withName: "Bryan Mack", imageName: "Bryan"))
    addressBookContactSection.contacts.append(Contact(withName: "Lindsay Gomez", imageName: "Lindsay"))
    addressBookContactSection.contacts.append(Contact(withName: "Luna Bullock", imageName: "Luna"))
    
    
    
    let facebookContactSection = ContactSection(withName: "Facebook contacts", imageName: "Facebook")
    
    facebookContactSection.contacts.append(Contact(withName: "Ellen Hobbs", imageName: "Ellen"))
    facebookContactSection.contacts.append(Contact(withName: "Marcy Walsh", imageName: "Marcy"))
    facebookContactSection.contacts.append(Contact(withName: "Kathrine Short", imageName: "Kathrine"))
    facebookContactSection.contacts.append(Contact(withName: "Christi Gamble", imageName: "Christi"))
    facebookContactSection.contacts.append(Contact(withName: "Harrison Hamilton", imageName: "Harrison"))
    facebookContactSection.contacts.append(Contact(withName: "Thomas Anderson", imageName: "Thomas"))
    
    
    
    let twitterContactSection = ContactSection(withName: "Twitter contacts", imageName:  "Twitter")
    
    twitterContactSection.contacts.append(Contact(withName: "Mack Riddle", imageName: "Mack"))
    twitterContactSection.contacts.append(Contact(withName: "Meagan Pennington", imageName: "Meagan"))
    twitterContactSection.contacts.append(Contact(withName: "Amy Monroe", imageName: "Amy"))
    twitterContactSection.contacts.append(Contact(withName: "Ingrid Christensen", imageName: "Ingrid"))
    twitterContactSection.contacts.append(Contact(withName: "Oliver Oneal", imageName: "Oliver"))
    
    
    return [addressBookContactSection, facebookContactSection, twitterContactSection]
  }
}