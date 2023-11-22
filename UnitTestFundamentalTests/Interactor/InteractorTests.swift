//
//  InteractorTests.swift
//  UnitTestFundamentalTests
//
//  Created by Shad Mazumder on 28/10/23.
//

import XCTest
import UnitTestFundamental

final class InteractorTests: XCTestCase {
//    func test_init_doesNotInitiateRemoteCall() {
//        let (_, stubAPI) = makeSUT()
//        
//        XCTAssertFalse(stubAPI.isCalled)
//    }
//    
//    func test_put_initiateRemoteCall() {
//        let (sut, stubAPI) = makeSUT()
//        
//        sut.executePUTRequest(for: URL(string: "any-url")!, with: .never){_ in}
//        
//        XCTAssertTrue(stubAPI.isCalled)
//    }
    
    func test_put_deliversErrorOnAPIError() {
        let anyError = NSError(domain: "any-error-domain", code: 0)
        let (sut, stubAPI) = makeSUT()
        
        sut.executePUTRequest(for: URL(string: "any-url")!, with: .never){result in
            if case .failure(let error) = result {
                XCTAssertEqual(error as NSError, anyError)
            } else {
                XCTFail("Expected error, instead got \(result)")
            }
        }
        
        stubAPI.complete(with: anyError)
    }
    
    func test_put_deliversSuccessOnAPISuccess() {
        let expectedResponse = HTTPURLResponse(url: URL(string: "any-url")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let (sut, stubAPI) = makeSUT()
        
        sut.executePUTRequest(for: URL(string: "any-url")!, with: .never){result in
            if case .success(let returnedResponse) = result {
                XCTAssertEqual(returnedResponse.statusCode, expectedResponse.statusCode)
                XCTAssertEqual(returnedResponse.url, expectedResponse.url)
            } else {
                XCTFail("Expected success, instead got \(result)")
            }
        }
        
        stubAPI.complete(with: expectedResponse)
    }
    
    // MARK: - Helper
    private func makeSUT() -> (sut: PreferenceInteractor, stubAPI: SutbPUTAPI){
        let stubAPI = SutbPUTAPI()
        let sut = PreferenceInteractor(api: stubAPI)
        return (sut, stubAPI)
    }
}


class SutbPUTAPI: PUTAPI {
    private(set) var isCalled: Bool?
    private(set) var completion:((Result<HTTPURLResponse, Error>)-> Void)?
    
    func put(preference: Preference, completion: @escaping (Result<HTTPURLResponse, Error>)-> Void) {}
    
    func complete(with error: Error){
        completion?(.failure(error))
    }
    
    func complete(with success: HTTPURLResponse){
        completion?(.success(success))
    }
}


//class PUTAPIMock: PUTAPI{
//    private(set) var isCalled = false
//    private(set) var completion:((Result<HTTPURLResponse, Error>)-> Void)?
//    
//    func put(preference: Preference, completion: @escaping (Result<HTTPURLResponse, Error>)-> Void) {
//        isCalled = true
//        self.completion = completion
//    }
//}
