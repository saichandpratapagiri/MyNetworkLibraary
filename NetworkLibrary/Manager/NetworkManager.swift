//
//  NetworkManager.swift
//  NetworkLibrary
//
//  Created by Saichand Pratapagiri on 12/03/21.
//

import Foundation

public protocol Configure: AnyObject {
    var endpoint: EndPointType { get }
}

public class NetworkManager {
    weak var configuration: Configure?
    
    init(configuration: Configure) {
        self.configuration = configuration
    }
    
    public func request(_ completion: @escaping (_ response: Any?, _ error: Error?) -> ()) {
        let router = Router()
        if let endPointType = configuration?.endpoint {
            router.request(endPintType: endPointType) { response, error in
                completion(response, error)
            }
        }
    
    }
   
}
