//
//  SearchService.swift
//  Application
//
//  Created by Nora Lilla Matyassi on 24/04/2022.
//

import Foundation

protocol SearchService {
    func getRecipies(page: Int, completionHandler: @escaping () -> Void)
}
