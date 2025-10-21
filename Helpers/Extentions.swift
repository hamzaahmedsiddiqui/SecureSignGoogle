//
//  ConstantFunctions.swift
//  SecureSignGoogle
//
//  Created by hamza Ahmed on 2025-10-21.
//

import Foundation


extension String  {
     func isValidEmail() -> Bool {
        // lightweight validation
        let pattern =
        #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
         return self.range(of: pattern, options: .regularExpression) != nil
    }
}
