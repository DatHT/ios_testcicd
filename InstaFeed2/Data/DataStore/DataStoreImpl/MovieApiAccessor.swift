//
//  MovieApiAccessor.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/04.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation
import RxSwift

class MovieApiAccessor : BaseApiAccessor {
    //Base class, common data put here
    let baseUrl: String = "https://api.themoviedb.org/3/movie/now_playing"
    let apiKey: String = "api_key"
    let pageKey: String = "page"
    let apiKeyVal: String = "d7b479477d49a44b62e8022d0d182848"
    
    
}

enum MovieAPI {
    case APIKey(String)
    case PageKey(String)
}


extension NSURL {
    class func moviesURL() -> NSURL {
        let baseUrl: String = "https://api.themoviedb.org/3/movie/now_playing"
        let apiKey: String = "api_key"
        let pageKey: String = "page"
        let apiKeyVal: String = "d7b479477d49a44b62e8022d0d182848"
        return NSURL(string: "\(baseUrl)?\(apiKey)=\(apiKeyVal)&\(pageKey)=1")!
    }
}

//extend function to adapt data


extension MovieApiAccessor: MovieDataStore {
    func getFetchMovies(page: Int) -> (success: Bool, value: MovieResult?, message: String) {
        let urlString = "\(baseUrl)?\(apiKey)=\(apiKeyVal)&\(pageKey)=\(page)"
        guard let url = URL(string: urlString) else {
            return (false, nil, "")
        }
        var result : MovieResult?
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            result = self.handleData(data: data, response: response, error: error)!
            semaphore.signal()
            }.resume()
        semaphore.wait()
        if result != nil {
            return (true, result, "")
        } else {
            return (false, nil, "")
        }
        
    }
    
//    func realCallMovie(page: Int) -> Observable<MovieResult> {
//        return objects(page: page)
//    }
    
    
//    func objects<T>(page: Int) -> Observable<T> where T: Codable {
//        return getFetchMoviesRx(page: page).map {data in
//            do {
//                let object = try JSONDecoder().decode(T.self, from: data as Data)
//                return object
//            } catch let jsonError {
//                print(jsonError)
//                throw APIClientError.CouldNotDecodeJSON
//            }
//        }
//    }
    
    func getFetchMoviesRx(page: Int) -> Single<MovieResult> {
        return Single.create { observer in
            
            let urlString = "\(self.baseUrl)?\(self.apiKey)=\(self.apiKeyVal)&\(self.pageKey)=\(page)"
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
                            let object = try JSONDecoder().decode(MovieResult.self, from: data as! Data)
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


enum APIClientError: Error {
    case CouldNotDecodeJSON
    case BadStatus(status: Int)
    case Other(NSError)
}

extension APIClientError: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .CouldNotDecodeJSON:
            return "Could not decode JSON"
        case let .BadStatus(status):
            return "Bad status \(status)"
        case let .Other(error):
            return "\(error)"
        }
    }
}

