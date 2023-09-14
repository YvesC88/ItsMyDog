//
//  DogService.swift
//  ItsMyDog
//
//  Created by Yves Charpentier on 01/09/2023.
//

import Foundation

enum DogError: Error {
    case invalidResult, invalidUrl, invalidResponse
}

protocol DogDelegate: AnyObject {
    func reloadTableView()
}

class DogService {
    
    var dogDelegate: DogDelegate?
    
    let serviceWrapper: ServiceProtocol
    init(wrapper: ServiceWrapper) {
        self.serviceWrapper = wrapper
    }
    
    final private func getImage(breed: String) async throws -> ResultDog {
        try await serviceWrapper.getImage(breed: breed)
    }
    
    final func fetchDog() async {
        for breed in SupportDog.shared.breeds {
            do {
                let dogs = try await getImage(breed: breed)
                SupportDog.shared.breedImages[breed] = dogs.message
                SupportDog.shared.allDogs.append(contentsOf: dogs.message)
            } catch DogError.invalidResponse {
                await Utilities.shared.presentAlert(title: "Erreur", message: "La réponse au serveur est trop longue")
            } catch DogError.invalidResult {
                await Utilities.shared.presentAlert(title: "Erreur", message: "Aucun résultat trouvé")
            } catch DogError.invalidUrl {
                await Utilities.shared.presentAlert(title: "Erreur", message: "La source est inconnue")
            } catch {
                await Utilities.shared.presentAlert(title: "Erreur", message: "Une erreur inattendue est survenue")
            }
        }
        dogDelegate?.reloadTableView()
    }
}
