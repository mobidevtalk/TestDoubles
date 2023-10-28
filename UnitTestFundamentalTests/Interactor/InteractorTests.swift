//
//  InteractorTests.swift
//  UnitTestFundamentalTests
//
//  Created by Shad Mazumder on 28/10/23.
//

import XCTest
import UnitTestFundamental

protocol PUTAPI {
    func put(preference: Preference)
}

struct PreferenceInteractor {
    let api: PUTAPI
}


final class InteractorTests: XCTestCase {
    func test_init_doesNotInitiateRemoteCall() {
        let putAPI = MockPUTAPI()
        
        let _ = PreferenceInteractor(api: putAPI)
        
        XCTAssertFalse(putAPI.isCalled)
    }
}


class MockPUTAPI: PUTAPI {
    private(set) var isCalled = false
    
    func put(preference: Preference) {
        isCalled = true
    }
}
