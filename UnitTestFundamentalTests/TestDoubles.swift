//
//  TestDoubles.swift
//  UnitTestFundamentalTests
//
//  Created by Shad Mazumder on 22/10/23.
//

import XCTest

protocol PreferenceStorable{
    func save(_ data: Data, for key: String) -> Error?
}

struct StorageController {
    let presistenceStore: PreferenceStorable
}

class TestDoublesTests: XCTestCase {
    func test_init_doesnotStorePreference() {
        let (_, spy) = makeSUT()
        
        XCTAssertTrue(spy.preferences.isEmpty)
    }
    
    // MARK: - Helper
    private func makeSUT() -> (sut: StorageController, spy: SpyPreferenceStorage) {
        let spy = SpyPreferenceStorage()
        let sut = StorageController(presistenceStore: spy)
        return (sut, spy)
    }
}

class SpyPreferenceStorage: PreferenceStorable {
    private(set) var preferences = [String: Data]()
    
    func save(_ data: Data, for key: String) -> Error? {
        preferences[key] = data
        return nil
    }
}
