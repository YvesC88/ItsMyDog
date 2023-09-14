//
//  ServiceWrapper.swift
//  ItsMyDog
//
//  Created by Yves Charpentier on 04/09/2023.
//

import Foundation

protocol ServiceProtocol {
    func getImage(breed: String) async throws -> ResultDog
    func getBreed() async throws -> ResultBreed
}

class ServiceWrapper: ServiceProtocol {
    func getImage(breed: String) async throws -> ResultDog {
        let endPoint = "https://dog.ceo/api/breed/\(breed)/images"
        guard let url = URL(string: endPoint) else {
            throw DogError.invalidUrl
        }
        let (result, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw DogError.invalidResponse
        }
        do {
            return try JSONDecoder().decode(ResultDog.self, from: result)
        } catch {
            throw DogError.invalidResult
        }
    }
    
    func getBreed() async throws -> ResultBreed {
        let endPoint = "https://dog.ceo/api/breeds/list/all"
        guard let url = URL(string: endPoint) else { throw DogError.invalidUrl }
        let (result, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw DogError.invalidResponse
        }
        do {
            return try JSONDecoder().decode(ResultBreed.self, from: result)
        } catch {
            throw DogError.invalidResult
        }
    }
    
}
