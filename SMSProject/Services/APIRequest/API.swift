//
//  API.swift
//  SMSProject
//
//  Created by Ade Adegoke on 12/04/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ result: Result<Messages, DataSourceError> ) -> Void
typealias TextDetails = (userName: String, textNumber: String, message: String)
typealias AlertMessage = (title: String, message: String)

class AlertMessages {
    var title: String
    var message: String
    
    init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}

enum Results<DataType, ErrorType: Error> {
    case success(DataType)
    case failure(ErrorType)
}

enum DataSourceError: Error {
    case fetal(Error)
    case network(Error)
    case noData
    case dataError(Error)
    case jsonParsedError(Error)
}

struct Messages: Decodable {
    let count: String
    let messages: [Message]
    
    enum CodingKeys: String, CodingKey {
        case count = "message-count"
        case messages
    }
}

struct Message: Decodable {
    let receiverNumber: String?
    let id: String?
    let status: String?
    let remainingBalance: String?
    let price: String?
    let network: String?
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case receiverNumber = "to"
        case id = "message-id"
        case status
        case remainingBalance = "remaining-balance"
        case price = "message-price"
        case network
        case error = "error-text"
    }
}

protocol API {
    func sendMessage(urlPaths: TextDetails, complication: @escaping CompletionHandler)
}
