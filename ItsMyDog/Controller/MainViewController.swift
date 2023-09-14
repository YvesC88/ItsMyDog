//
//  ViewController.swift
//  ItsMyDog
//
//  Created by Yves Charpentier on 01/09/2023.
//

import UIKit

class MainViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet private weak var dogTableView: UITableView!
    
    let dogService = DogService(wrapper: ServiceWrapper())
    let breedService = BreedService(wrapper: ServiceWrapper())
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dogService.dogDelegate = self
        setupSearchController()
        Task {
            await breedService.fetchBreed()
            await dogService.fetchDog()
        }
    }
    
    private final func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Rechercher une race"
        definesPresentationContext = true
    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SupportDog.shared.filteredBreedsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SupportDog.shared.breedImages[SupportDog.shared.filteredBreedsArray[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SupportDog.shared.filteredBreedsArray[section].capitalized
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return SupportDog.shared.breeds.map { $0.prefix(1).capitalized }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dogCell", for: indexPath) as? DogTableViewCell else { return UITableViewCell() }
        let breed = SupportDog.shared.filteredBreedsArray[indexPath.section]
        if let images = SupportDog.shared.breedImages[breed], indexPath.row < images.count {
            let image = images[indexPath.row]
            cell.configure(image: image)
        }
        return cell
    }
}

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            SupportDog.shared.filteredBreedsArray = SupportDog.shared.breeds.filter { breed in
                return breed.lowercased().hasPrefix(searchText.lowercased())
            }
        } else {
            SupportDog.shared.filteredBreedsArray = SupportDog.shared.breeds
        }
        DispatchQueue.main.async {
            self.dogTableView.reloadData()
        }
    }
}

extension MainViewController: DogDelegate {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.dogTableView.reloadData()
        }
    }
}
