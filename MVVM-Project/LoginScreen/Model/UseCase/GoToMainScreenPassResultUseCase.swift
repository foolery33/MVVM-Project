//
//  GoToMainScreenPassResultUseCase.swift
//  MVVM-Project
//
//  Created by admin on 30.03.2023.
//

import Foundation

class GoToMainScreenPassResultUseCase {
    
    // Возаращает title и message для Alert
    func getResult(email: String, password: String) -> (String, String) {
        if(EmptyFieldValidationUseCase().isEmptyField(email) || EmptyFieldValidationUseCase().isEmptyField(password)) {
            return ("Error", "You have not provided all required information. Please fill all the text fields")
        }
        if(EmailValidationUseCase().isValidEmail(email) == false) {
            return ("Error", "Your email is not conforming to default email standards")
        }
        return ("Success", "You've moved to the Main Screen")
    }
    
}
