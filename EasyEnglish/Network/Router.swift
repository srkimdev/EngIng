//
//  Router.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/18/24.
//

import Foundation
import Alamofire

enum Router: TargetType {
    
    case translate(query: TranslateQuery)
    
    var baseURL: String {
        switch self {
        case .translate:
            return "https://api-free.deepl.com/"
        }
    }
    
    var path: String {
        switch self {
        case .translate:
            return baseURL + "v2/translate"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .translate:
            return .post
        }
    }
    
    var body: Data? {
        switch self {
        case .translate(let query):
            let encoder = JSONEncoder()
            
            do {
                let data = try encoder.encode(query)
                return data
            } catch {
                return nil
            }
            
        default:
            return nil
            
        }
    }
    
    var header: [String: String] {
        switch self {
        case .translate:
            return [
                Header.authorization.rawValue: Header.DeepLKey.rawValue + APIKey.deepLKey,
                Header.contentType.rawValue: Header.json.rawValue
            ]
        }
    }
    
}
