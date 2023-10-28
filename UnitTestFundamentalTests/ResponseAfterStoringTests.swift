//
//  ResponseAfterStoringTests.swift
//  UnitTestFundamentalTests
//
//  Created by Shad Mazumder on 28/10/23.
//

import XCTest
import UnitTestFundamental

final class ResponseAfterStoringTests: XCTestCase {
    func test_save_throwsError_onErroneousStoring() {
        let expectedError = NSError(domain: "any error", code: -100)
        let (sut, _) = makeSUT(with: expectedError)
        
        do {
            try sut.save(preference: .never)
            XCTFail("Expected error but got none")
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
    
    func test_save_throwsNoError_onSuccessfulStoring() {
        let noError: Error? = nil
        let (sut, _) = makeSUT(with: noError)
        
        do {
            try sut.save(preference: .never)
        } catch {
            XCTFail("Expected no error but got an \(error)")
        }
    }
    
    // MARK: - Helper
    private func makeSUT(with error: Error?) -> (sut: StorageController, stub: StubPreferenceStorage){
        let stub = StubPreferenceStorage(error: error)
        let sut = StorageController(presistenceStore: stub)
        return (sut, stub)
    }
}

struct StubPreferenceStorage: PreferenceStorable {
    let error: Error?
    
    func save(_ data: Data, for key: String) -> Error? { error }
}
