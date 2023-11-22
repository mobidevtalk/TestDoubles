//
//  PreferenceInteractor.swift
//  UnitTestFundamental
//
//  Created by Shad Mazumder on 22/11/23.
//

import Foundation

public protocol PUTAPI {
    func put(preference: Preference, completion: @escaping (Result<HTTPURLResponse, Error>)-> Void)
}

public struct PreferenceInteractor {
    public let api: PUTAPI
    
    public init(api: PUTAPI) {
        self.api = api
    }
    
    public func executePUTRequest(for url: URL, with preference: Preference, completion: @escaping (Result<HTTPURLResponse, Error>)-> Void){
        api.put(preference: preference){result in
            completion(result)
        }
    }
}
