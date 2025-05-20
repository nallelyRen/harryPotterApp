//
//  CharacterListViewModel.swift
//  harryPotterApp
//
//  Created by Nallely Rincon Contreras on 24/04/25.
//

import Foundation
import Combine

final class CharacterListViewModel: ObservableObject {
  @Published var characters: [Character] = []
  @Published var filteredCharacters: [Character] = []
  @Published var characterSelected: Character? = nil
  @Published var searchText: String = ""
  @Published var isLoading: Bool = true
  private let repository: ServiceRepositoryProtocol = AsyncRepository()
  private var cancellables = Set<AnyCancellable>()

  init() {
    subscribeToSearch()
  }

  @MainActor
  func fetchCharacters() async {
    do {
      try await characters = repository.fetchCharacters(in: .spanish)
      isLoading = false
    } catch {
      print(error.localizedDescription)
    }
  }

  func subscribeToSearch() {
    $searchText
      .sink { [weak self] searchText in
        guard let self = self else { return }
        self.filterCharacters(with: searchText)
      }
      .store(in: &cancellables)
  }

  func filterCharacters(with search: String) {
    guard !search.isEmpty else {
      filteredCharacters = []
      return
    }
    filteredCharacters = characters.filter({ character in
      guard let fullName = character.fullName?.lowercased() else { return false }
      return fullName.contains(search.lowercased())
    })
  }
}
