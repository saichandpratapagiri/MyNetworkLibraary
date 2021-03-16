# MyNetworkLibrary

Steps:
1. Add github "https://github.com/saichandpratapagiri/MyNetworkLibrary.git" "development" to Cartfile and do carthage update.
2. Add import NetworkLibrary to ur project file.
3. Implement "Configure" to return the instance.
   eg:  
   extension NetworkLibraryTests: Configure {
    var endpoint: EndPointType {
        return self
    }
}
4. Implement "EndPointType" to return baseurl, path, httpmethos, httptask.
   eg:
   extension NetworkLibraryTests: EndPointType {
    
    var baseUrl: URL {
        return URL(string: "https://api.imgflip.com");
    }
    
    var path: String {
        return "get_memes"
    }
    
    var httpMethod: HttpMethod {
        return .get
    }
    
}
5. api call
   NetworkManager(configuration: self).request { response, error in
            print(response as Any)
        }
                
