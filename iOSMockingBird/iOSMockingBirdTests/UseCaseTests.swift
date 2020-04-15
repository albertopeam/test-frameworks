//
//  iOSMockingBirdTests.swift
//  iOSMockingBirdTests
//
//  Created by Alberto Penas Amor on 12/04/2020.
//  Copyright © 2020 com.github.albertopeam. All rights reserved.
//

import XCTest
import Combine
import Mockingbird
@testable import iOSMockingBird

class UseCaseTests: XCTestCase {

    // MARK: - mocking and stubbing
    func testGivenResponseWhenGetThenMatchAsRemovedStringsWithLessThanFourCharacters() throws {
        let restApiMock = mock(RestAPI.self)
        given(restApiMock.index(ascOrder: any())) ~> CurrentValueSubject<[String], URLError>(["Hi", "Hello", "Welcome", "bye", "bye bye"]).eraseToAnyPublisher()
        let sut = UseCase(restApi: restApiMock)

        var result: [String]?
        let expect = self.expectation(description: #function)
        _ = sut.get().sink(receiveCompletion: { _ in }, receiveValue: { result = $0; expect.fulfill() })
        wait(for: [expect], timeout: 1)

        XCTAssertEqual(try XCTUnwrap(result).count, 3)
    }

    // MARK: - verification

    func testGivenNoResponseWhenGetThenMatchAsInvokedRestApi() throws {
        let restApiMock = mock(RestAPI.self)
        given(restApiMock.index(ascOrder: any())) ~> PassthroughSubject().eraseToAnyPublisher()
        let sut = UseCase(restApi: restApiMock)

        _ = sut.get()

        verify(restApiMock.index(ascOrder: any())).wasCalled(exactly(1))
    }

    // MARK: - spy

    func testGivenNoResponseWhenGetThenMatchParams() throws {
        let restApiMock = mock(RestAPI.self)
        let orderCaptor = ArgumentCaptor<Bool>()
        given(restApiMock.index(ascOrder: orderCaptor.matcher)) ~> PassthroughSubject().eraseToAnyPublisher()
        let sut = UseCase(restApi: restApiMock)

         _ = sut.get()

        XCTAssertFalse(try XCTUnwrap(orderCaptor.value))
    }

}
