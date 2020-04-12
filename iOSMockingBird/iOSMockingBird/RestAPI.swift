//
//  RestAPI.swift
//  TestingFrameworkMockingBird
//
//  Created by Alberto Penas Amor on 12/04/2020.
//  Copyright © 2020 com.github.albertopeam. All rights reserved.
//

import Foundation
import Combine

class RestAPI {
    func index() -> AnyPublisher<[String], URLError> {
        return Future { (promise) in
            promise(.success(["Matrix", "Brian's life", "Inception"]))
        }.eraseToAnyPublisher()
    }
}
