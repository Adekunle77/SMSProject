//
//  HTTPRequest.swift
//  SMSProject
//
//  Created by Ade Adegoke on 12/04/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

class HTTPRequest: API {
    
    // API KEY
    private let apiKey = "6e625cd7"
    // Secret Key
    private let secretKey = "owpzNgPIsgtokxY4"
    
    func sendMessage(urlPaths: TextDetails, complication: @escaping CompletionHandler) {
        guard let url = requestURL(paths: urlPaths) else { return }
        let task = URLSession.shared.downloadTask(with: url) { (localURL, urlResponse, error) in
            if let error = error {
                DispatchQueue.main.async {
                    complication(.failure(.network(error)))
                }
            }
            guard let localURL = localURL else {
                DispatchQueue.main.async {
                    complication(.failure(.noData))
                }
                return
            }
            do {
                let data = try Data(contentsOf: localURL)
                let jsonObject = try JSONDecoder().decode(Messages.self, from: data)
                DispatchQueue.main.async {
                    complication(.success(jsonObject))
                }
            } catch let error {
                DispatchQueue.main.async {
                    complication(.failure(.jsonParsedError(error)))
                }
            }
        }
        task.resume()
    }
    
    private func requestURL(paths: TextDetails) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rest.nexmo.com"
        components.path = "/sms/json"
        let queryApikey = URLQueryItem(name: "api_key", value: apiKey)
        let queryApiSecret = URLQueryItem(name: "api_secret", value: secretKey)
        let user = URLQueryItem(name: "from", value: paths.userName)
        let receiver = URLQueryItem(name: "to", value: paths.textNumber)
        let message =  URLQueryItem(name: "text", value: paths.message)
        components.queryItems = [ queryApikey, queryApiSecret, user, receiver, message]

        return components.url
    }
 
}

#if DEBUG
extension HTTPRequest {
    internal func testRequestURL(urLPaths: TextDetails) -> URL? {
        let test = requestURL(paths: urLPaths)
        return test 
    }
}
#endif
