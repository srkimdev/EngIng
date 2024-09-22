//
//  Categories.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/21/24.
//

import Foundation

enum Categories: String, CaseIterable {
    
    case movieDrama = "Movies & TV Shows"
    case food = "Food & Restaurants"
    case transportation = "Transportation"
    case dailyLife = "Daily Life"
    case travel = "Travel"
    case business = "Business English"
    case sports = "Sports"
    case music = "Music"
    case shopping = "Shopping"
    case historyCulture = "History & Culture"
    
    var description: String {
        switch self {
        case .movieDrama:
            return "Common expressions from films and TV series."
        case .food:
            return "Expressions related to ordering food, recipes, and dining out."
        case .transportation:
            return "Phrases related to public transportation, taxis, ridesharing, and driving."
        case .dailyLife:
            return "Common expressions used in everyday situations."
        case .travel:
            return "Phrases for airports, hotels, asking for directions, etc."
        case .business:
            return "Terms and phrases for emails, meetings, and business contexts."
        case .sports:
            return "Phrases related to sports like soccer, basketball, and the Olympics."
        case .music:
            return "Vocabulary related to song lyrics, concerts, and performances."
        case .shopping:
            return "Expressions related to buying goods and shopping."
        case .historyCulture:
            return "Phrases linked to historical events and cultural topics."
        }
        
    }
    
//    var 
    
    
}
