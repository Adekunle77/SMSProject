//
//  SMSViewModel.swift
//  SMSProject
//
//  Created by Ade Adegoke on 16/04/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit
import CoreData

class OpeningViewModel {
    
    var messageDetail = [Message]()
    var delegate: ViewModelDelegate?
    private var dataSource: API
    
    init(dataSourse: API) {
        self.dataSource = dataSourse
    }
    
    // MARK: API Request Method
    func sendText(messageDetails: TextDetails) {
        dataSource.sendMessage(urlPaths: messageDetails, complication: { result in
            switch result {
            case .failure(let error):
                self.delegate?.modelDidUpdateDataWithError(error: error)
            case .success(let data):
                self.messageDetail = data.messages
                self.delegate?.modelDidUpdateData()
                
            }
        })
    }
    
    // MARK: Url Methods
    func prepareStringForURL(string: String) -> String {
        var stringForURL = string
        if string.isEmpty {
            stringForURL = "Not" + "+" + "Included"
            return stringForURL
        }
        
        stringForURL = string.replaceCharacter(with: " ", for: "+")
        return stringForURL
    }
 
    func prepareNumberForUrl(number: String) -> String {
        var prepareNumber = number
        if prepareNumber.checkCharacter(at: 0, is: "0") {
            prepareNumber.removeCharacter(index: 0)
            return "44\(prepareNumber)"
        }
        return "44\(prepareNumber)"
    }
    
    
    // MARK: Persistence Methods
    func save(data: String) {
        let saveData = TextedNumber(context: SaveData.context) 
        saveData.phoneNumber = data
        saveData.date = getCurrentDate()
        saveData.time = getCurrentTime()
        self.delegate?.modelDidUpdateData()
        SaveData.saveContext()
    }
    
    func loadData() -> [TextedNumber] {
        let fetchRequest: NSFetchRequest<TextedNumber> = TextedNumber.fetchRequest()
        var textNumbersArray = [TextedNumber]()
        do {
            let textNumbers = try SaveData.context.fetch(fetchRequest)
            textNumbersArray = textNumbers.reversed()
            self.delegate?.modelDidUpdateData()
        } catch let error {
            self.delegate?.modelDidUpdateDataWithError(error: error)
        }
        return textNumbersArray
    }
    
    
    
    
    // MARK: AlertView Methods
    func textedReceipt() -> AlertMessage {
        var message: AlertMessage
        message.message = ""
        message.title = ""
        let receipt = messageDetail.first
        if receipt?.error != nil {
            message.title = "Error"
            message.message = self.textedReturnsError(details: self.messageDetail)
        } else if receipt?.error == nil {
            message.title = "Message Sent"
            message.message = self.textedMessageSent(details: self.messageDetail)
     
    }
        return message
    }
    
    private func textedReturnsError(details: [Message]) -> String {
        let detail = details.first
        var message = String()
        let error = String(detail?.error ?? "Error message unavilable")
        let receiver = String(detail?.receiverNumber ?? "unavilable")
        message = "The text for mobile number \(receiver), was not Delivered. \(error)"
        return message
    }
    
    private func textedMessageSent(details: [Message]) -> String {
        let detail = details.first
        
        var message = String()
        let textPrice = String(detail?.price ?? "")
        let price = "£\(textPrice.prefix(4))"
        let remainingbalance = String(detail?.remainingBalance ?? "")
        let balance = "£\(remainingbalance.prefix(4))"
        message = "Your text message was sent. It cost \(price) . The remaining balance is \(balance)"
        return message
    }
    
    
    // MARK: Date & Time Methods
    func getCurrentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
    
    func getCurrentTime() -> String {
        let time = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"
        let stringTime = dateFormatter.string(from: time)
        return stringTime
    }
    
}
