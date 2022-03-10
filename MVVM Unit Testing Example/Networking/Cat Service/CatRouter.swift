//
//  CatRouter.swift
//  GitIt
//
//  Created by Loay Ashraf on 23/01/2022.
//

import Foundation
import Alamofire

enum CatRouter {
    
    // MARK: - Cat API Route cases
    
    case fetchPuplicPictures(page: Int)
    
}

extension CatRouter {
    
    // MARK: - Base URL Property
    
    var baseURL: String {
        
        switch self {
        default: return NetworkingConstants.apiBaseUrl
        }
        
    }
    
    // MARK: - Path Property
    
    var path: String {
        
        switch self {
        case .fetchPuplicPictures: return baseURL.appendPathComponent(NetworkingConstants.publicImages)
        }
        
    }
    
    // MARK: - Method Property
    
    var method: Alamofire.HTTPMethod {
        
        switch self {
        case .fetchPuplicPictures: return .get
        }
        
    }
    
    // MARK: - Headers Property
    
    var headers: HTTPHeaders {
            
        var headersDict: [String:String] = [:]
            
        switch self {
        default: headersDict[NetworkingConstants.contentType] = "application/json"
        }
            
        return HTTPHeaders(headersDict)
            
    }
    
    // MARK: - Parameters Property
    
    var parameters: Parameters? {
            
        var parametersDict: [String: Any] = [:]
            
        switch self {
        case .fetchPuplicPictures(let page): parametersDict[NetworkingConstants.page] = page
                                             parametersDict[NetworkingConstants.perPage] = NetworkingConstants.minimumPageCapacity
        }
            
        return parametersDict
    }
        
    // MARK: - Body Property
    
    var body : [String: Any]{
        
        var bodyDict: [String: Any] = [:]
            
        switch self {
        default: break
        }
            
        return bodyDict
    }
        
}

// MARK: - URL Request Convertible Protocol

extension CatRouter: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            
        urlRequest.method = method
        urlRequest.headers = headers
        
        if method == .get {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        } else if method == .post {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
    
}
