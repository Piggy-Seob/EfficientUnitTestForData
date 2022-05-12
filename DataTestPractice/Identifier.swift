//
//  Identifier.swift
//  DataTestPractice
//
//  Created by 박진섭 on 2022/05/12.
//


protocol Identifiable {
    associatedtype RawIdentifier: Codable = String

    var id: Identifier<Self> { get }
}

struct Identifier<Value: Identifiable> {
    
    let rawValue: Value.RawIdentifier
    
    init(rawValue: Value.RawIdentifier) {
        self.rawValue = rawValue
    }
}

extension Identifier: ExpressibleByUnicodeScalarLiteral where Value.RawIdentifier == String {
    init(unicodeScalarLiteral value: String) {
        rawValue = value
    }
}

extension Identifier: ExpressibleByExtendedGraphemeClusterLiteral where Value.RawIdentifier == String {
    init(extendedGraphemeClusterLiteral value: String) {
        rawValue = value
    }
}

extension Identifier: ExpressibleByStringLiteral where Value.RawIdentifier == String {
    init(stringLiteral value: StringLiteralType) {
        rawValue = value
    }
}
