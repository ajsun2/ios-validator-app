//
//  Validator.swift
//  SwiftSample (iOS)
//
//  Created by Adrianne Sun on 5/20/25.
//

import Foundation

struct Validator {
    
    static func isNonEmpty(_ text: String?) -> Bool {
        return !(text ?? "").isEmpty
    }

    static func isValidEmail(_ email: String) -> Bool {
        let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return email.range(of: pattern, options: .regularExpression) != nil
    }

    static func isValidPassword(_ password: String) -> Bool {
        // At least 12 characters, one lowercase, one uppercase, one number, one special character
        let pattern = #"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\s]).{12,}$"#
        return password.range(of: pattern, options: .regularExpression) != nil
    }
    
    static func isValidPhone(_ ssn: String) -> Bool {
        let pattern = #"^\d{3}-\d{3}-\d{4}$"#
        return ssn.range(of: pattern, options: .regularExpression) != nil
    }

    static func isValidSSN(_ ssn: String) -> Bool {
        let pattern = #"^\d{3}-\d{2}-\d{4}$"#
        return ssn.range(of: pattern, options: .regularExpression) != nil
    }

    static func isValidZipCode(_ zip: String) -> Bool {
        let pattern = #"^\d{5}$"#
        return zip.range(of: pattern, options: .regularExpression) != nil
    }
}
