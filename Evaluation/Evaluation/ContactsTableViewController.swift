//
//  ContactsTableViewController.swift
//  Evaluation
//
//  Created by Ricardo Batista on 9/25/16.
//  Copyright © 2016 XdroneStudio. All rights reserved.
//

import UIKit

class ContactsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, ContactCellDelegate, ContactHeaderSectionViewDelegate {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var continueButton: UIButton!
  
  let contactSections:[ContactSection] = ContactSection.exampleStaticData()
  var filteredContactSections:[ContactSection] = []
  let searchController = UISearchController(searchResultsController: nil)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.estimatedRowHeight = 60.0
    
    searchController.searchResultsUpdater = self
    definesPresentationContext = true
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search friends"
    searchController.searchBar.barTintColor = UIColor(red: 15.0/255.0, green: 61.0/255.0, blue: 119.0/255.0, alpha: 1.0)
    tableView.tableHeaderView = searchController.searchBar
    
    continueButton.layer.cornerRadius = 6
    
    self.setNeedsStatusBarAppearanceUpdate()
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func returnToContacts(segue:UIStoryboardSegue) {
  }
  
  // MARK: - Helper Methods
  
  func filterWithName(name: String) {
    
    filteredContactSections = [] //Erease previous search results
    for section in contactSections {
      let filteredSection = ContactSection(withName: section.sectionName, imageName: section.isConnected ? "Down": "Right")
      filteredSection.contacts = section.filterContactsForSearchText(name)
      filteredContactSections.append(filteredSection)
    }
    
    tableView.reloadData()
  }
  
  
  // MARK: - UITableViewDataSource
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return contactSections.count
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if !contactSections[section].isConnected {
      return 0
    }
    
    if searchController.active && searchController.searchBar.text != "" {
      return filteredContactSections[section].contacts.count
    }
    return contactSections[section].contacts.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("contactCell", forIndexPath: indexPath)
    let contact: Contact
    
    if searchController.active && searchController.searchBar.text != "" {
      contact = filteredContactSections[indexPath.section].contacts[indexPath.row]
    } else{
      contact = contactSections[indexPath.section].contacts[indexPath.row]
    }
    
    if let contactCell = cell as? ContactCell {
      
      contactCell.delegate = self
      contactCell.indexPath = indexPath
      
      contactCell.contactNameLabel.text = contact.name
      
      if let image = contact.image {
        contactCell.contactImageView.image = image
      }
      
      contactCell.contactImageView.layer.cornerRadius = contactCell.contactImageView.frame.size.width / 2
      contactCell.contactImageView.clipsToBounds = true
      
      if let iconImage = UIImage(named: (contact.isAdded ? "checked": "plus"))?.imageWithRenderingMode(.AlwaysTemplate){
        contactCell.contactAddButton.setImage(iconImage, forState: .Normal)
      }
    }
    
    return cell
  }
  
  // MARK: - UITableViewDelegate
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 60
  }
  
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 60
  }
  
  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let contactSection = contactSections[section]
    
    let headerView = HeaderSectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60))
    
    headerView.delegate = self
    headerView.section = section
    
    headerView.headerLabel.text = contactSection.sectionName
    
    if let image = contactSection.image {
      headerView.headerIconImage.image = image
    }
    
    if let connectedImage = UIImage(named: (contactSection.isConnected ? "Down": "Right")){
      headerView.headerConnectedButton.setImage(connectedImage, forState: .Normal)
    }
    
    return headerView
  }
  
  func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    return nil
  }
  
  
  // MARK: - ContactCellDelegate
  
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    filterWithName(searchController.searchBar.text!)
  }
  
  
  // MARK: - ContactCellDelegate
  func didAddContactAtIndexpath(indexPath: NSIndexPath) {
    var contact:Contact
    
    if searchController.active && searchController.searchBar.text != "" {
      contact = filteredContactSections[indexPath.section].contacts[indexPath.row]
    } else {
      contact = contactSections[indexPath.section].contacts[indexPath.row]
    }
    
    contact.isAdded = !contact.isAdded
    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
  }
  
  
  //MARK: - ContactHeaderSectionViewDelegate
  
  func didColapseSectionAt(section: Int) {
    
    let contactSection = contactSections[section]
    contactSection.isConnected = !contactSection.isConnected
    
    tableView.reloadSections(NSIndexSet(index: section), withRowAnimation: .Automatic)
  }
}









