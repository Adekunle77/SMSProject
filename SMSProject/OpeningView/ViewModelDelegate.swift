//
//  ViewModelDelegate.swift
//  SMSProject
//
//  Created by Ade Adegoke on 26/04/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func modelDidUpdateData()
    func modelDidUpdateDataWithError(error: Error)
}
