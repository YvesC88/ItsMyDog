//
//  BreedService.swift
//  ItsMyDog
//
//  Created by Yves Charpentier on 04/09/2023.
//

import Foundation

class BreedService {
    
    private let serviceWrapper: ServiceProtocol
    init(wrapper: ServiceWrapper) {
        self.serviceWrapper = wrapper
    }
    
    final func getBreed() async throws -> ResultBreed {
        try await serviceWrapper.getBreed()
    }
    
    final func fetchBreed() async {
        do {
            let breeds = try await getBreed()
            let keys = Array(breeds.message.keys)
            SupportDog.shared.breeds = keys.sorted()
            SupportDog.shared.filteredBreedsArray = SupportDog.shared.breeds
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
}
