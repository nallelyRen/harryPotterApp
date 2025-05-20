//
//  SpellListViewModel.swift
//  harryPotterApp
//
//  Created by Nallely Rincon Contreras on 24/04/25.
//

import Foundation
final class SpellListViewModel: ObservableObject {
  @Published var spells: [Spell] = []
  @Published var showSpellInfo: Bool = false
  @Published var spellSelected: Spell? = nil
  @Published var isLoading: Bool = true
  private let repository: AsyncRepository = AsyncRepository()

  @MainActor
  func fetchSpells() async {
    do {
      try await spells = repository.fetch(.spells, in: .spanish)
      isLoading = false
    } catch {
      print(error.localizedDescription)
    }
  }

}
