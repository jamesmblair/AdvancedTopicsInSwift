//
//  IdentifiableCellType.swift
//  CotbDemo
//
//  Created by James Blair on 8/10/16.
//  Copyright © 2016 James Blair. All rights reserved.
//

import UIKit

protocol IdentifiableCellType {
    static var reuseIdentifier: String { get }
}

extension UITableViewController {
    func safeGetCell<CellType : UITableViewCell where CellType: IdentifiableCellType>(
        for tableView: UITableView, at indexPath: NSIndexPath) -> CellType {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(
            CellType.reuseIdentifier, forIndexPath: indexPath) as? CellType
            else { fatalError("Invalid cell type") }
        
        return cell
    }
}

