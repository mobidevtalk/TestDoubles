//
//  ResponseAfterStoringTests.swift
//  UnitTestFundamentalTests
//
//  Created by Shad Mazumder on 28/10/23.
//

import XCTest
import UnitTestFundamental

final class ResponseAfterStoringTests: XCTestCase {
}

struct StubPreferenceStorage: PreferenceStorable {
    let error: Error?
    
    func save(_ data: Data, for key: String) -> Error? { error }
}
