//
//  String+Localization.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 06.02.2025..
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    func localized(_ arguments: CVarArg...) -> String {
        String(format: localized, arguments: arguments)
    }
} 
