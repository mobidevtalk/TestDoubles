//
//  UserDefault+PreferenceStorable.swift
//  UnitTestFundamental
//
//  Created by Shad Mazumder on 28/10/23.
//

import Foundation

public enum UserDefaultsError: Error {
    case emptyData
}

extension UserDefaults: PreferenceStorable{
    public func save(_ data: Data, for key: String) -> Error? {
        UserDefaultsError.emptyData
    }
}
