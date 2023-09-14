//
//  SupportDog.swift
//  ItsMyDog
//
//  Created by Yves Charpentier on 04/09/2023.
//

import Foundation

class SupportDog {
    
    static let shared = SupportDog()
    
    var allDogs: [String] = []
    var breeds: [String] = []
    var filteredBreedsArray: [String] = []
    var breedImages: [String: [String]] = [:]
    
}
