//
//  Categories.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/21/24.
//

import Foundation
import SwiftUI

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
    
    var images: String {
        switch self {
        case .movieDrama:
            return "dog"
        case .food:
            return "cat"
        case .transportation:
            return "chicken"
        case .dailyLife:
            return "frog"
        case .travel:
            return "hamster"
        case .business:
            return "hedgehog"
        case .sports:
            return "cat2"
        case .music:
            return "rabbit"
        case .shopping:
            return "snake"
        case .historyCulture:
            return "bird"
        }
    }
    
    var colors: Color {
        switch self {
        case .movieDrama:
            return Color.red.opacity(0.3)
        case .food:
            return Color.orange.opacity(0.3)
        case .transportation:
            return Color.yellow.opacity(0.3)
        case .dailyLife:
            return Color.green.opacity(0.3)
        case .travel:
            return Color.blue.opacity(0.3)
        case .business:
            return Color.indigo.opacity(0.3)
        case .sports:
            return Color.purple.opacity(0.3)
        case .music:
            return Color.brown.opacity(0.3)
        case .shopping:
            return Color.cyan.opacity(0.3)
        case .historyCulture:
            return Color.pink.opacity(0.3)
        }
    }
    
}
