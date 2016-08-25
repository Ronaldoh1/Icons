//
//  ViewController.swift
//  PrettyIcons
//
//  Created by Brian on 12/1/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var iconSets = [IconSet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconSets = IconSet.iconSets()
        
        automaticallyAdjustsScrollViewInsets = false
        
        navigationItem.rightBarButtonItem = editButtonItem()
        tableView.allowsSelectionDuringEditing = true
        
    }
    
    
    
}

extension ViewController: UITableViewDataSource {
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            //enumerate through icon sets to add 
            tableView.beginUpdates()
            for (index, set) in iconSets.enumerate() {
                let indexPath = NSIndexPath(forRow: set.icons.count, inSection: index)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
            tableView.endUpdates()
            
            tableView.setEditing(true, animated: true)
        } else {
            //Remove add buttons when not in editing mode.
            
            tableView.beginUpdates()
            for (index, set) in iconSets.enumerate() {
                let indexPath = NSIndexPath(forRow: set.icons.count, inSection: index)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
            tableView.endUpdates()

            
            tableView.setEditing(false, animated: false)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let adjustment = editing ? 1 : 0
        let iconSet = iconSets[section]
        return iconSet.icons.count + adjustment
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return iconSets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("iconCell", forIndexPath: indexPath)
        let iconSet = iconSets[indexPath.section]
        
        if indexPath.row >= iconSet.icons.count && editing {
            //we're in the extra row.
            cell.textLabel?.text = "Add Icon"
            cell.detailTextLabel?.text = nil
            cell.imageView?.image = nil
        } else {
            let icon = iconSet.icons[indexPath.row]
            
            cell.textLabel?.text = icon.title
            cell.detailTextLabel?.text = icon.subtitle
            
            if let iconImage = icon.image {
                cell.imageView?.image = iconImage
            } else {
                cell.imageView?.image = nil
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let iconSet = iconSets[section]
        return iconSet.name
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let iconSet = iconSets[indexPath.section]
            iconSet.icons.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        } else if editingStyle == .Insert {
            let newIcon = Icon(withTitle: "New Icon", subtitle: "", imageName: nil)
            let set = iconSets[indexPath.section]
            set.icons.append(newIcon)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        let set = iconSets[indexPath.section]
        
        if indexPath.row >= set.icons.count {
            return .Insert
        } else {
            return .Delete
        }
    }
    
    // we need to allow the user to tap on the new icon row. 
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let set = iconSets[indexPath.section]
        if editing && indexPath.row < set.icons.count {
            return nil
        }
        return indexPath
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true) // first we need to deselect the row.
        
        // we need to get our set. 
        let set = iconSets[indexPath.section]
        
        if editing && indexPath.row >= set.icons.count {
           self.tableView(tableView, commitEditingStyle: .Insert, forRowAtIndexPath: indexPath)
        }
    }
    
}
