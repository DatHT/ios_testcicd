//
//  DIContainer.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/04.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation
import Swinject

private var instance: DIContainer?
class DIContainer {
    private let container = Container()
    
    private class func getInstance() -> DIContainer {
        if instance == nil {
            instance = DIContainer()
        }
        return instance!
    }
    
    private init() {
        self.container.register(MovieDataStore.self) { _ in MovieApiAccessor()}
        self.container.register(MovieRepositoryProtocol.self) { _ in MovieRepository(getMovie: DIContainer.resolve(serviceType: MovieDataStore.self))}
        self.container.register(UserDataStore.self) { _ in UserDataStoreCoreData()}
        
        self.container.register(MockServerDataStore.self) { _ in MockServerApiAccessor()}
        self.container.register(MockServerProtocol.self) { _ in MockServerRepository(mockServer: DIContainer.resolve(serviceType: MockServerDataStore.self))}
    }
    
    class func resolve<Service>(serviceType: Service.Type) -> Service {
        return getInstance().container.resolve(serviceType)!
    }
    class func synchronizeResolve<Service>(serviceType: Service.Type) -> Service {
        return getInstance().container.synchronize().resolve(serviceType)!
    }
}

