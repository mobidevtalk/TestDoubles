//
//  StorageController.swift
//  UnitTestFundamental
//
//  Created by Shad Mazumder on 28/10/23.
//

import Foundation

public struct StorageController {
    private let presistenceStore: PreferenceStorable
    
    public init(presistenceStore: PreferenceStorable) {
        self.presistenceStore = presistenceStore
    }
    
    public func save(preference: Preference){
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(preference) else { return }
        _ = presistenceStore.save(data, for: Self.PreferenceStoreKey)
    }
}

extension StorageController{
    public static var PreferenceStoreKey: String {"PreferenceStoreKey"}
}
