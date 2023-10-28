//
//  PreferenceStorable.swift
//  UnitTestFundamental
//
//  Created by Shad Mazumder on 28/10/23.
//

import Foundation

public protocol PreferenceStorable{
    func save(_ data: Data, for key: String) -> Error?
}
