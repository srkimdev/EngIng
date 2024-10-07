//
//  NetworkManager.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/19/24.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func requestAPI<T: Decodable>(router: Router, type: T.Type) async -> Result<T, Error> {
        
        do {
            let request = try router.asURLRequest()
            
            let response = await AF.request(request)
                .validate()
                .serializingDecodable(type)
                .response
            
            switch response.result {
            case .success(let data):
                return .success(data)
            case .failure(let error):
                return .failure(error)
            }
        } catch {
            return .failure(error)
        }
    
    }
    
}
