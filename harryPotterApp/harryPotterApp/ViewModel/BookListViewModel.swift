//
//  BookListViewModel.swift
//  harryPotterApp
//
//  Created by Nallely Rincon Contreras on 24/04/25.
//

import Foundation
import Combine

class BookListViewModel: ObservableObject {
  @Published var books: [Book] = []
  @Published var filteredBooks: [Book] = []
  @Published var searchText: String = ""
  @Published var isLoading: Bool = true
  @Published var isEmptyView: Bool = false
  @Published var errorAlertIsActive: Bool = false
  let repository: ServiceRepositoryProtocol = AsyncRepository()
  var cancellables = Set<AnyCancellable>()

  init() {
    subscribeToSearch()
  }

  @MainActor
  func fetchBooks() async {
    do {
      isEmptyView = false
      try await books = repository.fetchBooks(in: .spanish)
      isLoading = false
      if books.isEmpty {
        isEmptyView = true
      }
    } catch {
      isLoading = false
      errorAlertIsActive = true
    }
  }

  func subscribeToSearch() {
    $searchText
      .debounce(for: 0.3, scheduler: DispatchQueue.main)
      .sink { [weak self] searchText in
        guard let self = self else { return }
        self.filterBooks(with: searchText)
      }
      .store(in: &cancellables)
  }

  func filterBooks(with searchText: String) {
    guard !searchText.isEmpty else {
      filteredBooks = []
      return
    }
    filteredBooks = books.filter({ book in
      guard let title = book.title?.lowercased() else { return false }
      return title.contains(searchText.lowercased())
    })
  }

}
