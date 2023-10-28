//
//  InteractorTests.swift
//  UnitTestFundamentalTests
//
//  Created by Shad Mazumder on 28/10/23.
//

import XCTest
import UnitTestFundamental

protocol PUTAPI {
    func put(preference: Preference, completion: @escaping (Result<URLResponse, Error>)-> Void)
}

struct PreferenceInteractor {
    let api: PUTAPI
    
    func executePUTRequest(for url: URL, with preference: Preference, completion: @escaping (Result<URLResponse, Error>)-> Void){
        api.put(preference: preference){_ in completion(.failure(NSError(domain: "any-error-domain", code: 0)))}
    }
}


final class InteractorTests: XCTestCase {
    func test_init_doesNotInitiateRemoteCall() {
        let (_, mockAPI) = makeSUT()
        
        XCTAssertFalse(mockAPI.isCalled)
    }
    
    func test_put_initiateRemoteCall() {
        let (sut, mockAPI) = makeSUT()
        
        sut.executePUTRequest(for: URL(string: "any-url")!, with: .never){_ in}
        
        XCTAssertTrue(mockAPI.isCalled)
    }
    
    func test_put_deliversErrorOnAPIError() {
        let anyError = NSError(domain: "any-error-domain", code: 0)
        let (sut, mockAPI) = makeSUT()
        
        sut.executePUTRequest(for: URL(string: "any-url")!, with: .never){result in
            if case .failure(let error) = result {
                XCTAssertEqual(error as NSError, anyError)
            } else {
                XCTFail("Expected error, instead got \(result)")
            }
        }
        
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
    private(set) var completion:((Result<URLResponse, Error>)-> Void)?
    
    func put(preference: Preference, completion: @escaping (Result<URLResponse, Error>)-> Void) {
        isCalled = true
        self.completion = completion
    }
    
    func complete(with error: Error){
        completion?(.failure(error))
    }
}
