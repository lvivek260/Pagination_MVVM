//
//  UITableViewCell+Extension.swift
//  Pagination_MVVM
//
//  Created by PHN MAC 1 on 22/09/23.
//

import UIKit

extension UITableViewCell{
    static var id: String { return String(describing: self)}
    static var nib: UINib { return UINib(nibName: id, bundle: nil)}
}
