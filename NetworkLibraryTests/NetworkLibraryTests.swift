//
//  NetworkLibraryTests.swift
//  NetworkLibraryTests
//
//  Created by Saichand Pratapagiri on 11/03/21.
//

import XCTest
import NetworkLibrary

@testable import NetworkLibrary

class NetworkLibraryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let expectation = self.expectation(description: "Waiting for api")
        NetworkManager(configuration: self).request { response, error in
            print(response as Any)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

}

extension NetworkLibraryTests: Configure {
    var endpoint: EndPointType {
        return self
    }
}

extension NetworkLibraryTests: EndPointType {
    
    var baseUrl: URL {
//        return URL(string: "https://swapi.dev/")!
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    var path: String {
//        return "api/people/"
        return "todos"
    }
    
    var httpMethod: HttpMethod {
        return .get
    }
    
}
