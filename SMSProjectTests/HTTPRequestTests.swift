//
//  HTTPRequestTests.swift
//  SMSProjectTests
//
//  Created by Ade Adegoke on 15/04/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import XCTest
@testable import SMSProject

class HTTPRequestTests: XCTestCase {

    func testRequestURL() {
        let httpRequest = HTTPRequest()
        let url = testURL
        guard let request = URL(string: url) else { return }
        let urlPaths: TextDetails
        urlPaths.message = "This+message+is+from+patrick"
        urlPaths.textNumber = "447932849812"
        urlPaths.userName = "NEXMO"
        
        let requestURL = httpRequest.testRequestURL(urLPaths: urlPaths)
        
        XCTAssertEqual(requestURL, request)
        
    }
}
