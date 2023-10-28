//
//  TestDoubles.swift
//  UnitTestFundamentalTests
//
//  Created by Shad Mazumder on 22/10/23.
//

import XCTest

struct Credential {
    let username: String
    let password: String
}

extension Credential: Encodable{}

enum Preference {
    case notNow
    case never
    case save(Credential)
}

extension Preference: Encodable{}

protocol PreferenceStorable{
    func save(_ data: Data, for key: String) -> Error?
}

struct StorageController {
    let presistenceStore: PreferenceStorable
    
    func save(preference: Preference){
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(preference) else { return }
        _ = presistenceStore.save(data, for: Self.PreferenceStoreKey)
    }
}

extension StorageController{
    static var PreferenceStoreKey: String {"PreferenceStoreKey"}
}

class TestDoublesTests: XCTestCase {
    func test_init_doesnotStorePreference() {
        let (_, spy) = makeSUT()
        
        XCTAssertTrue(spy.preferences.isEmpty)
    }
    
    func test_savePreference_storesPref() {
        let (sut, spy) = makeSUT()
        XCTAssertTrue(spy.preferences.isEmpty)
        
        sut.save(preference: .never)
        
        XCTAssertFalse(spy.preferences.isEmpty)
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
