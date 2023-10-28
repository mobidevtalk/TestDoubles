//
//  StorageController.swift
//  UnitTestFundamental
//
//  Created by Shad Mazumder on 28/10/23.
//

import Foundation

public struct StorageController {
    private let presistenceStore: PreferenceStorable
    private let encoder: JSONEncoder
    
    public init(presistenceStore: PreferenceStorable, encoder: JSONEncoder) {
        self.presistenceStore = presistenceStore
        self.encoder = encoder
    }
    
    public func save(preference: Preference) throws{
        guard let data = try? encoder.encode(preference) else { return }
        
        if let error = presistenceStore.save(data, for: Self.PreferenceStoreKey) {
            throw error
        }
    }
}

extension StorageController{
    public static var PreferenceStoreKey: String {"PreferenceStoreKey"}
}
