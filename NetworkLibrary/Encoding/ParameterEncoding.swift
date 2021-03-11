//
//  ParameterEncoding.swift
//  NetworkLibrary
//
//  Created by Saichand Pratapagiri on 11/03/21.
//

import Foundation

public typealias Parameters = [String : Any]

public protocol ParameterEncoder {
 static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public struct URLParametersEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        //MARK: - Check url is nil
        guard let url = urlRequest.url else {
            throw RequestError.missingUrl
        }
        //MARK: - Check url is well typed ( An url shouldn't have symbols like &)
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            for (key,value) in parameters {
                let queryitem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryitem)
            }
        } else {
            throw RequestError.parametersMissing
        }
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded: charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
    }
    
}

public struct JSONParametersEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw RequestError.missingUrl
        }
    }
    
}
