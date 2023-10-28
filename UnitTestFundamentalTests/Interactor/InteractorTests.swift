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
    
    func executePUTRequest(for url: URL, with preference: Preference){
        api.put(preference: preference)
    }
}


final class InteractorTests: XCTestCase {
    func test_init_doesNotInitiateRemoteCall() {
        let (_, mockAPI) = makeSUT()
        
        XCTAssertFalse(mockAPI.isCalled)
    }
    
    func test_put_initiateRemoteCall() {
        let (sut, mockAPI) = makeSUT()
        
        sut.executePUTRequest(for: URL(string: "any-url")!, with: .never)
        
        XCTAssertTrue(mockAPI.isCalled)
    }
    
    // MARK: - Helper
    private func makeSUT() -> (sut: PreferenceInteractor, mockAPI: MockPUTAPI){
        let mockAPI = MockPUTAPI()
        let sut = PreferenceInteractor(api: mockAPI)
        return (sut, mockAPI)
    }
}


class MockPUTAPI: PUTAPI {
    private(set) var isCalled = false
    
    func put(preference: Preference) {
        isCalled = true
    }
}
