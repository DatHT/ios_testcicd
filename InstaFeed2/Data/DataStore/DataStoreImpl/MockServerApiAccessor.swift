//
//  MockServerApiAccessor.swift
//  InstaFeed2
//
//  Created by Huynh Thanh Dat on 2018/01/21.
//  Copyright © 2018 huynhdat. All rights reserved.
//

import Foundation
import RxSwift

class MockServerApiAccessor {
    let baseURl = "https://d1ba8d58-c352-41b3-9b47-5a21f6732f76.mock.pstmn.io/dat"
}

extension MockServerApiAccessor: MockServerDataStore {
    func getMockServerData() -> Single<Dat> {
        return Single.create { observer in
            
            let urlString = self.baseURl
            guard let url = URL(string: urlString) else {
                observer(.error(APIClientError.CouldNotDecodeJSON))
                fatalError()
            }
            
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                if error != nil {
                    observer(.error(APIClientError.CouldNotDecodeJSON))
                } else {
                    guard let HTTPResponse = response as? HTTPURLResponse else {
                        fatalError("Couldn't get HTTP response")
                    }
                    
                    if 200 ..< 300 ~= HTTPResponse.statusCode {
                        do {
                            let object = try JSONDecoder().decode(Dat.self, from: data as! Data)
                            observer(.success(object))
                        } catch let jsonError {
                            print(jsonError)
                        }
                        
                        
                    }
                    else {
                        observer(.error(APIClientError.CouldNotDecodeJSON))
                    }
                }
            }
            task.resume()
            
            
            return Disposables.create(with: task.cancel)
        }
    }
    
    
}
