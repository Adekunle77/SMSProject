//
//  SMSViewModelTests.swift
//  SMSProjectTests
//
//  Created by Ade Adegoke on 24/04/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import XCTest
@testable import SMSProject

class SMSViewModelTests: XCTestCase {
    var mockAPI = MockAPI()
    
    class ViewModelDelegateSpy: ViewModelDelegate {
        var modelDidUpadeDelegateSpy = false
        var spyModelDidUpadeDelegateWithError: Error?
        
        func modelDidUpdateData() {
            modelDidUpadeDelegateSpy = true
        }
        
        func modelDidUpdateDataWithError(error: Error) {
            spyModelDidUpadeDelegateWithError = error
        }
   
    }
    
    func testSendTextReturnsError() {
        mockAPI.isReturningError = true
        let viewModel = OpeningViewModel(dataSourse: mockAPI)
        let spy = ViewModelDelegateSpy()
        viewModel.delegate = spy
        
        var textDetails: TextDetails
        textDetails.message = "This+message+is+from+patrick"
        textDetails.textNumber = "447932849812"
        textDetails.userName = "NEXMO"
        
        viewModel.sendText(messageDetails: textDetails)
        
        XCTAssertNotNil(spy.spyModelDidUpadeDelegateWithError)
        XCTAssertFalse(spy.modelDidUpadeDelegateSpy)
  
    }
    
    func testSendTextReturnsSuccess() {
        mockAPI.isReturningError = false
        let viewModel = OpeningViewModel(dataSourse: mockAPI)
        let spy = ViewModelDelegateSpy()
        viewModel.delegate = spy
        
        var textDetails: TextDetails
        textDetails.message = "This+message+is+from+patrick"
        textDetails.textNumber = "447932849812"
        textDetails.userName = "NEXMO"
        
        viewModel.sendText(messageDetails: textDetails)
        
        XCTAssertNil(spy.spyModelDidUpadeDelegateWithError)
        XCTAssertTrue(spy.modelDidUpadeDelegateSpy)
        
    }
 
    func testPrepareStringForURL() {
        let viewModel = OpeningViewModel(dataSourse: mockAPI)
        
        let testString = "This string message is for testing."
        let sut = viewModel.prepareStringForURL(string: testString)
  
        XCTAssertEqual(sut, "This+string+message+is+for+testing.")
    }
    
    func testPrepareNumberForUrl() {
        let viewModel = OpeningViewModel(dataSourse: mockAPI)
        
        let testNumber = "07932849812"
        let sut = viewModel.prepareNumberForUrl(number: testNumber)
        
        XCTAssertEqual(sut, "447932849812")
    }

    func testGetCurrentDate() {
        let viewModel = OpeningViewModel(dataSourse: mockAPI)

        let sut = viewModel.getCurrentDate()
        
        // add current date
        XCTAssertEqual(sut, "24 Apr 2019")
    }
    
    func testGetCurrentTime() {
        let viewModel = OpeningViewModel(dataSourse: mockAPI)
        
        let sut = viewModel.getCurrentTime()
        
        // add current date, for example "05:18"
        XCTAssertEqual(sut, "")
    }
}
