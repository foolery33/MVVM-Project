//
//  EmailValidationUseCase.swift
//  MVVM-Project
//
//  Created by admin on 30.03.2023.
//

import Foundation

class EmailValidationUseCase {
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email.lowercased())
    }
    
}
