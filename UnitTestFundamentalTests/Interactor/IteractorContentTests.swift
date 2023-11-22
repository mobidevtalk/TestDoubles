//
//  IteractorContentTests.swift
//  UnitTestFundamentalTests
//
//  Created by Shad Mazumder on 22/11/23.
//

import XCTest
import UnitTestFundamental

final class IteractorContentTests: XCTestCase {
    func test_init_doesNotInitiateRemoteCall() {
        let (_, mockAPI) = makeSUT()
        
        XCTAssertFalse(mockAPI.verifyCall)
        XCTAssertFalse(mockAPI.verifyCompletionSetup)
    }
    
    func test_put_initiateRemoteCall() {
        let (sut, mockAPI) = makeSUT()
        
        sut.executePUTRequest(for: URL(string: "any-url")!, with: .never){_ in}
        
        XCTAssertTrue(mockAPI.verifyCall)
        XCTAssertTrue(mockAPI.verifyCompletionSetup)
    }
    
    // MARK: - Helper
    private func makeSUT() -> (sut: PreferenceInteractor, mockAPI: MockPUTAPI){
        let mockAPI = MockPUTAPI()
        let sut = PreferenceInteractor(api: mockAPI)
        return (sut, mockAPI)
    }
}

class MockPUTAPI: PUTAPI{
    private var isCalled = false
    private var completion: ((Result<HTTPURLResponse, Error>)-> Void)?
    
    func put(preference: Preference, completion: @escaping (Result<HTTPURLResponse, Error>)-> Void) {
        isCalled = true
        self.completion = completion
    }
    
    var verifyCall: Bool{
        isCalled == true
    }
    
    var verifyCompletionSetup: Bool{
        completion != nil
    }
}
