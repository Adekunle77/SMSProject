//
//  Extensions.swift
//  SMSProject
//
//  Created by Ade Adegoke on 18/04/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import UIKit

extension String {
    mutating func removeCharacter(index number: Int) {
         if self.count < number || number < 0 {
            print("The number \(number) index is out of range for \(self)")
         } else {
          self.remove(at: self.index(self.startIndex, offsetBy: number))
        }
     
    }
    
    func checkCharacter(at index: Int, is character: Character) -> Bool {
        var isCharacter: Bool = false
        if index > self.count || index < 0 {
            isCharacter = false
        } else if self[self.index(self.startIndex, offsetBy: index)] == character {
            isCharacter = true
        }
        return isCharacter
    }
    
    func replaceCharacter(with character: Character, for this: Character) -> String {
        let replaceChar = String(character)
        let exChangeChar = String(this)
        let string = self.replacingOccurrences(of: replaceChar, with: exChangeChar,
                                  options: NSString.CompareOptions.literal, range:nil)
    
        return string
    }
    
}
