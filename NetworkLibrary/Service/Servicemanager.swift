//
//  Servicemanager.swift
//  NetworkLibrary
//
//  Created by Saichand Pratapagiri on 11/03/21.
//

import Foundation

public enum RequestError: String, Error {
    case parametersMissing = "paraameters are Nil."
    case encodingFailed = "parameter encoding failed."
    case missingUrl = "URL is nil."
}

public protocol EndPointType {
    var baseUrl: URL { get }
    var path: String { get }
    var httpMethod: HttpMethod { get }
    var task: HttpTask { get }
    var headers: HttpHeaders? { get }
}

extension EndPointType {
    var task: HttpTask {
        return .request
    }
    
    var headers: HttpHeaders? {
        return nil
    }
}

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum HttpTask {
    case request
    
    case requestParams(bodyParams: Parameters?, urlParams: Parameters?)
    
    case requestParamsWithHeaders(bodyParams: Parameters?, urlParams: Parameters?, additionalHeaders: HttpHeaders?)
}

public typealias HttpHeaders = [String : String]


