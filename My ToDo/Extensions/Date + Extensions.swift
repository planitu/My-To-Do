//
//  Date + Extensions.swift
//  My ToDo
//
//  Created by Максим on 25.04.2022.
//

import UIKit

extension Date {
    
    func toString(_ inDateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inDateFormat
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: self)
    }
}
