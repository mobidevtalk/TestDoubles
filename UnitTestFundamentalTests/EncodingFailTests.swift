//
//  EncodingFailTests.swift
//  UnitTestFundamentalTests
//
//  Created by Shad Mazumder on 28/10/23.
//

import XCTest
import UnitTestFundamental

final class EncodingFailTests: XCTestCase {
    func test_save_withEncodingError_deliversError() {
        let anyEncodingError = NSError(domain: "any encoding error", code: -100)
        let sut = StorageController(presistenceStore: DummyPreferenceStorage(), 
                                    encoder: StubFailableJsonEncoder(error: anyEncodingError))
        
        do {
            try sut.save(preference: .never)
            XCTFail("Expected Encoding failor but got none")
        } catch {
            let returnedError = error as NSError
            XCTAssertEqual(returnedError, anyEncodingError)
        }
    }
}

class DummyPreferenceStorage: PreferenceStorable {
    func save(_ data: Data, for key: String) -> Error? { nil }
}

class StubFailableJsonEncoder: JSONEncoder {
    let error: Error
    
    init(error: Error) {
        self.error = error
    }
    
    override func encode<T>(_ value: T) throws -> Data where T : Encodable {
        throw error
    }
}
