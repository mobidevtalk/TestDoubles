//
//  Credential.swift
//  UnitTestFundamental
//
//  Created by Shad Mazumder on 28/10/23.
//

import Foundation

public struct Credential {
    public let username: String
    public let password: String
}

extension Credential: Encodable{}
