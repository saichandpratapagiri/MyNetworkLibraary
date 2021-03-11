//
//  Router.swift
//  NetworkLibrary
//
//  Created by Saichand Pratapagiri on 11/03/21.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(endPintType type: EndPointType, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try buildRequest(from: type)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
}

fileprivate func buildRequest(from route: EndPointType) throws -> URLRequest {
    var request = URLRequest(url: route.baseUrl.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
    request.httpMethod = route.httpMethod.rawValue
    do {
        switch route.task {
        case .request:
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
        case .requestParams(let bodyParams, let urlparams):
            try configureParams(bodyParams: bodyParams, urlParams: urlparams, request: &request)
        case .requestParamsWithHeaders(let bodyParams, let urlParams, let additionalHeaders):
            appendAdditionalHeaders(additionalHeaders, request: &request)
            try configureParams(bodyParams: bodyParams, urlParams: urlParams, request: &request)
        }
        return request
    } catch {
        throw error
    }
    
}

fileprivate func configureParams(bodyParams: Parameters?,
                                 urlParams: Parameters?,
                                 request: inout URLRequest) throws {
    do {
        if let bodyParams = bodyParams {
            try JSONParametersEncoder.encode(urlRequest: &request, with: bodyParams)
        }
        if let urlParams = urlParams {
            try JSONParametersEncoder.encode(urlRequest: &request, with: urlParams)
        }
    } catch {
        throw error
    }
}

fileprivate func appendAdditionalHeaders(_ additionalHeaders: HttpHeaders?, request: inout URLRequest) {
    guard let headers = additionalHeaders else { return }
    for (key,value) in headers {
        request.setValue(value, forHTTPHeaderField: key)
    }
}
