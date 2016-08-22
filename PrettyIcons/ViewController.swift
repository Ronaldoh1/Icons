//
//  ViewController.swift
//  PrettyIcons
//
//  Created by Brian on 12/1/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var iconSets = [IconSet]()

  override func viewDidLoad() {
    super.viewDidLoad()

     iconSets = IconSet.iconSets()
    
    automaticallyAdjustsScrollViewInsets = false
    
  }



}

extension ViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let iconSet = iconSets[section]
        return iconSet.icons.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return iconSets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("iconCell", forIndexPath: indexPath)
        let iconSet = iconSets[indexPath.section]
        let icon = iconSet.icons[indexPath.row]
        
        cell.textLabel?.text = icon.title
        cell.detailTextLabel?.text = icon.subtitle
        
        if let iconImage = icon.image {
            cell.imageView?.image = iconImage
        }
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let iconSet = iconSets[section]
        return iconSet.name
    }
    
}

extension ViewController: UITableViewDelegate {
    
    
}
