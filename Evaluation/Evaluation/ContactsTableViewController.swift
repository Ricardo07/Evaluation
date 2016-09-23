//
//  ContactsTableViewController.swift
//  Evaluation
//
//  Created by Ricardo Batista on 9/21/16.
//  Copyright © 2016 XdroneStudio. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {

  let contactSections:[ContactSection] = ContactSection.exampleStaticData()
  var filteredContactSections:[ContactSection] = []
  
  let searchController = UISearchController(searchResultsController: nil)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.estimatedRowHeight = 100.0
    tableView.contentInset.top = 20
    
    searchController.searchResultsUpdater = self
    definesPresentationContext = true
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search friends"
    tableView.tableHeaderView = searchController.searchBar
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  // MARK: - UITableViewDataSource methods
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return contactSections.count
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchController.active && searchController.searchBar.text != "" {
      return filteredContactSections[section].contacts.count
    }
    return contactSections[section].contacts.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("contactCell", forIndexPath: indexPath)

    let contact: Contact
    
    if searchController.active && searchController.searchBar.text != "" {
      contact = filteredContactSections[indexPath.section].contacts[indexPath.row]
    } else{
      contact = contactSections[indexPath.section].contacts[indexPath.row]
    }
    
    
    if let contactCell = cell as? ContactCell {
      
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
  
  
  // MARK: - UITableViewDelegate methods
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 100
  }
  
  override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 60
  }
  
  override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let section = contactSections[section]
    
    let headerView = HeaderSectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60))
    
    headerView.headerLabel.text = section.sectionName
    
    if let image = section.image {
      headerView.headerIconImage.image = image
    }
    
    if let connectedImage = UIImage(named: (section.isConnected ? "Down": "Right")){
      headerView.headerConnectedImage.image = connectedImage
    }
    
    return headerView
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    var contact:Contact
    
    if searchController.active && searchController.searchBar.text != "" {
      contact = filteredContactSections[indexPath.section].contacts[indexPath.row]
    } else {
      contact = contactSections[indexPath.section].contacts[indexPath.row]
    }
    
    contact.isAdded = !contact.isAdded
    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
  }
  
  
  // MARK: - Filter method
  
  func filterWithName(name: String) {
    
    filteredContactSections = [] //Erease previous search results
    for section in contactSections {
      
      let filteredSection = ContactSection(withName: section.sectionName, imageName: "")
      filteredSection.contacts = section.filterContactsForSearchText(name)
      filteredSection.image = section.image
      filteredContactSections.append(filteredSection)
    }
    
    tableView.reloadData()
  }
}

// MARK: - UISearchResultsUpdating

extension ContactsTableViewController: UISearchResultsUpdating {
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    filterWithName(searchController.searchBar.text!)
  }
}
