//
//  ExtensionsTests.swift
//  SMSProjectTests
//
//  Created by Ade Adegoke on 19/04/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import XCTest

@testable import SMSProject

class ExtensionsTests: XCTestCase {

    func testRemoveCharacterAtIndex() {
        var letter = "test"
        
        letter.removeCharacter(index: 2)
        XCTAssertEqual(letter, "tet")
  
    }

    
    func testRemoveCharacterOutOfRange() {
        var letter = "test"
        
        letter.removeCharacter(index: 10)
        letter.removeCharacter(index: -1)
        
        XCTAssertEqual(letter, "test")
        
    }
    
    func testCheckCharacterAtIndex() {
        let word = "test"
        
        let letterT = word.checkCharacter(at: 0, is: "t")
        let letterZ = word.checkCharacter(at: 2, is: "z")
        
        XCTAssertTrue(letterT, "t")
        XCTAssertFalse(letterZ, "z")
    }
    
    func testCheckCharacterAtIndexOutOfRange() {
        let word = "test"
        
        let letterT = word.checkCharacter(at: 10, is: "t")
        let letterE = word.checkCharacter(at: -1, is: "e")
        
        XCTAssertFalse(letterT, "t")
        XCTAssertFalse(letterE, "e")
        
    }
    
    func testReplaceCharacter() {
        let word = "This string is for testing"
        
        let sut = word.replaceCharacter(with: " ", for: "+")
        
        XCTAssertEqual(sut, "This+string+is+for+testing")
    }
    
}
