//
//  MockAPI.swift
//  SMSProjectTests
//
//  Created by Ade Adegoke on 24/04/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
@testable import SMSProject

class MockAPI: API {
    
    var isReturningError = false
    
    func sendMessage(urlPaths: TextDetails, complication: @escaping CompletionHandler) {
        if isReturningError {
            complication(.failure(.noData))
        } else {
            
            let messages = Messages(count: "1", messages: [Message(receiver: "Patrick", id: "123456789", status: "0", remainingBalance: "1.90010000", price: "0.03330000", network: "23430")])
            complication(.success(messages))
        }
    }
    

}
