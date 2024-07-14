//
//  String+Extension.swift
//  WBHomework_first
//
//  Created by Kirill on 04.07.2024.
//

import Foundation

extension String {
    
    var digits: String {
        components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    var isCorrectRussianPhoneNumber: Bool {
        digits.first == "7" && digits.count == 11 
    }
    
    func formatPhoneNumber() -> String {
        let cleanNumber = digits
        let mask = "+X (XXX) XXX-XX-XX"
        let endIndex = cleanNumber.endIndex
        
        var result = ""
        var startIndex = cleanNumber.startIndex
        
        for char in mask where startIndex < endIndex {
            if char == "X" {
                result.append(cleanNumber[startIndex])
                startIndex = cleanNumber.index(after: startIndex)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
    
}
