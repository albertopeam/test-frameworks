//
//  UseCase.swift
//  iOSMockingBird
//
//  Created by Alberto Penas Amor on 12/04/2020.
//  Copyright © 2020 com.github.albertopeam. All rights reserved.
//

import Foundation
import Combine

class UseCase {
    private let restApi: RestAPI

    init(restApi: RestAPI) {
        self.restApi = restApi
    }

    func get() -> AnyPublisher<[String], URLError> {
        return restApi
            .index(ascOrder: false)
            .map({ $0.compactMap({ $0.count > 3 ? $0:nil }) })
            .eraseToAnyPublisher()
    }
}
