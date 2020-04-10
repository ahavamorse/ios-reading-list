//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Ahava on 4/9/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
