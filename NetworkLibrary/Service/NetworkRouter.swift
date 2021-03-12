//
//  NetworkRouter.swift
//  NetworkLibrary
//
//  Created by Saichand Pratapagiri on 11/03/21.
//

import Foundation

public typealias NetworkRouterCompletion = (_ response: Any?,_ error: Error?)->()

protocol NetworkRouter: AnyObject {
    func request(endPintType type: EndPointType, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
