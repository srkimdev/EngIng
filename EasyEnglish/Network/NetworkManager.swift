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
    
    func requestAPI<T: Decodable>(req: Router, type: T.Type) async -> Result<T, Error> {
        let response = await AF.request(req.path,
                                        method: req.method)
            .validate()
            .serializingDecodable(type)
            .response
        
        switch response.result {
        case .success(let data):
            return .success(data)
        case .failure(let error):
            return .failure(error)
        }
        
    }
    
}
