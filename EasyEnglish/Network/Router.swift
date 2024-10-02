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
    case tts(query: TTSInput)
    
    var baseURL: String {
        switch self {
        case .translate:
            return "https://api-free.deepl.com/"
        case .tts:
            return "https://texttospeech.googleapis.com/"
        }
    }
    
    var path: String {
        switch self {
        case .translate:
            return "v2/translate"
        case .tts:
            return "v1/text:synthesize"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .translate:
            return .post
        case .tts:
            return .post
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .tts:
            return [URLQueryItem(name: "key", value: APIKey.ttsKey)]
        default:
            return nil
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
            
        case .tts(let query):
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
        case .tts:
            return [
                Header.contentType.rawValue: Header.json.rawValue
            ]
        }
    }
    
}
