//
//  UserDefaults+PreferenceStorableTests.swift
//  UnitTestFundamentalTests
//
//  Created by Shad Mazumder on 28/10/23.
//

import XCTest
import UnitTestFundamental

final class UserDefaults_PreferenceStorableTests: XCTestCase {
    func test_save_withEmptyData_returnEmptyDataError() {
        let sut = UserDefaults(suiteName: "UserDefaultsTestSuite")
        
        let error = sut?.save(Data(), for: "anyKey") as? UserDefaultsError
        
        XCTAssertEqual(error, .emptyData)
    }
    
    func test_save_withEmptyKey_returnEmptyKeyError() {
        let sut = UserDefaults(suiteName: "UserDefaultsTestSuite")
        
        let error = sut?.save("some-data".data(using: .utf8)!, for: "") as? UserDefaultsError
        
        XCTAssertEqual(error, .emptyKey)
    }
}
