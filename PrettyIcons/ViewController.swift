//
//  ViewController.swift
//  PrettyIcons
//
//  Created by Brian on 12/1/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var icons = [Icon]()

  override func viewDidLoad() {
    super.viewDidLoad()

    let iconSets = IconSet.iconSets()
    let iconSet = iconSets[0]
    icons = iconSet.icons
    automaticallyAdjustsScrollViewInsets = false
    
  }



}

extension ViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("iconCell", forIndexPath: indexPath)
        let icon = icons[indexPath.row]
        
        cell.textLabel?.text = icon.title
        cell.detailTextLabel?.text = icon.subtitle
        
        if let iconImage = icon.image {
            cell.imageView?.image = iconImage
        }
        return cell
    }
    
}
