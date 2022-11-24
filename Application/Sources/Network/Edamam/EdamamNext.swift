//
//  EdamamNext.swift
//  Application
//
//  Created by Nora Lilla Matyassi on 04/09/2022.
//
import Foundation

// MARK: - Next
struct EdamamNext: Decodable {
    let href: String
    let title: Title
}

enum Title: String, Codable {
    case nextPage = "Next page"
    
}

extension EdamamNext {

    func toGenericModel() -> RecipeNext {
     
        RecipeNext(href: href, title: RecipeTitle.nextPage)
        
    }
}
