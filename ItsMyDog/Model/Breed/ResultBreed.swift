//
//  ResultBreed.swift
//  ItsMyDog
//
//  Created by Yves Charpentier on 02/09/2023.
//

import Foundation

struct ResultBreed: Codable {
    let message: [String: [String]]
    let status: String
}
