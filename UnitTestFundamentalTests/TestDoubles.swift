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

final class TestDoubles: XCTestCase {
    
}

class SpyPreferenceStore: PreferenceStorable {
    var data: Data?
    var key: String?
    
    func save(_ data: Data, for key: String) -> Error? {
        self.data = data
        self.key = key
        return nil
    }
}

class StubPreferePreference: PreferenceStorable {
    let error: Error?
    
    init(error: Error?) {
        self.error = error
    }
    
    func save(_ data: Data, for key: String) -> Error? {
        error
    }
}

/*
 Mock will have some kind of logic in it. It knows what it is testing.
 */
class MockPreferenceStore: PreferenceStorable {
    var isFirstLogin: Bool
    
    init(isFirstLogin: Bool) {
        self.isFirstLogin = isFirstLogin
    }
    
    func save(_ data: Data, for key: String) -> Error? {
        isFirstLogin ? NSError(domain: "Already Exists", code: -100) : nil
    }
    
    func complete(with error: Error){
        
    }
}

/*
 Fake always provides a specific value.
 */
struct FakePreferenceStore: PreferenceStorable {
    func save(_ data: Data, for key: String) -> Error? {
        NSError(domain: "Any Error", code: 0)
    }
}

/*
 Dummy provides values which is not a concern. Dummy is kinda of a filler. Just to fill some requirements dummy is provided
 */
struct DummyPreferenceStore: PreferenceStorable {
    func save(_ data: Data, for key: String) -> Error? {
        nil
    }
}
