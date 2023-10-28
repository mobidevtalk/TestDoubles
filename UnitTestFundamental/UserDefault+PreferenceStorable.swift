//
//  UserDefault+PreferenceStorable.swift
//  UnitTestFundamental
//
//  Created by Shad Mazumder on 28/10/23.
//

import Foundation

public enum UserDefaultsError: Error {
    case emptyData
    case emptyKey
}

extension UserDefaults: PreferenceStorable{
    public func save(_ data: Data, for key: String) -> Error? {
        switch (data.isEmpty, key.isEmpty) {
        case (true, _):
            return UserDefaultsError.emptyData
        case (_, true):
            return UserDefaultsError.emptyKey
        default:
            return nil
        }
        
    }
}
