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
    
    public func save(preference: Preference) throws{
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(preference) else { return }
        
        if let error = presistenceStore.save(data, for: Self.PreferenceStoreKey) {
            throw error
        }
    }
}

extension StorageController{
    public static var PreferenceStoreKey: String {"PreferenceStoreKey"}
}
