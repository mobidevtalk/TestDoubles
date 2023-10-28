//
//  Preference.swift
//  UnitTestFundamental
//
//  Created by Shad Mazumder on 28/10/23.
//

import Foundation

public enum Preference {
    case notNow
    case never
    case save(Credential)
}

extension Preference: Encodable{}
