//
//  UserDefaults+syncTests.swift
//  UnitTestFundamentalTests
//
//  Created by Shad Mazumder on 28/10/23.
//

import XCTest
import UnitTestFundamental

final class UserDefaults_syncTests: XCTestCase {
    func test_save_withFailure_deliversSaveFailError() {
        let key = "fakeKey"
        let sut = FakeUserDefaults(suiteName: "FakeUserDefaultsTestSuite")!
        
        let error = sut.save("data".data(using: .utf8)!, for: key) as? UserDefaultsError
        
        XCTAssertEqual(error, .saveFailed)
    }
}

class FakeUserDefaults: UserDefaults {
    override func synchronize() -> Bool { false }
}

// MARK: - Another UserDefaults Fake example

protocol UserDefaultsStorage {
    func set(_ value: Any?, forKey defaultName: String)
    func value(forKey key: String) -> Any?
}

extension UserDefaults: UserDefaultsStorage{}

class FakeStorage: UserDefaultsStorage{
    var dictionary = [String: Any]()
    
    func set(_ value: Any?, forKey defaultName: String) {
        dictionary[defaultName] = value
    }
    
    func value(forKey key: String) -> Any? {
        dictionary[key]
    }
}
