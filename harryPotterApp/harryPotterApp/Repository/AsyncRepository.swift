//
//  AsyncRepository.swift
//  harryPotterApp
//
//  Created by Nallely Rincon Contreras on 02/04/25.
//

import Foundation
import UIKit
protocol ServiceRepositoryProtocol {
 // func fetchSpells(in language: ServiceLanguage) async throws -> [Spell]
  func fetchCharacters(in language: ServiceLanguage) async throws -> [Character]
  func fetchBooks(in language: ServiceLanguage) async throws -> [Book]
  func fetchImage(from urlString: String) async throws -> UIImage?
  func fetch<T: Decodable>(_ service: RepositoryService,
                                   in language: ServiceLanguage) async throws -> T
}

enum RepositoryService {
  case spells
  case books
  case characters
  case randomSpell
  case randomBook
  case randomCharacter

  var path: String {
    switch self {
    case .spells:
      "spells/"
    case .books:
      "books/"
    case .characters:
      "characters/"
    case .randomSpell:
      "spells/random"
    case .randomBook:
      "books/random"
    case .randomCharacter:
      "characters/random"
    }
  }
}
enum ServiceLanguage {
  case spanish
  case english

  var path: String {
    switch self {
    case .spanish:
      "/es/"
    case .english:
      "/en/"
    }
  }
}
actor AsyncRepository: ServiceRepositoryProtocol {

  private let mainUrl: String

  init(mainUrl: String = "https://potterapi-fedeperin.vercel.app") {
    self.mainUrl = mainUrl
  }

  private func buildUrlString(for service: RepositoryService,
                              in language: ServiceLanguage) -> String {
    return "\(mainUrl)\(language.path)\(service.path)"
  }

  func fetch<T: Decodable>(_ service: RepositoryService,
                                   in language: ServiceLanguage) async throws -> T {
    guard let url: URL = URL(string: buildUrlString(for: service, in: language)) else { throw URLError(.badURL) }
    let (data,response) = try await URLSession.shared.data(from: url)
    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
      throw URLError(.badServerResponse)
    }
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: data)
  }

  func fetchImage(from urlString: String) async throws -> UIImage? {
    guard let url = URL(string: urlString) else { return nil }
    let (data,_) = try await URLSession.shared.data(from: url)
    return UIImage(data: data)
  }

  func mapSpells() -> [Spell] {
    return []
  }

  func mapCharacters(from response: [CharacterResponse]) async -> [Character] {
    var characters: [Character] = []
    for characterResponse in response {
      let character = Character(fullName: characterResponse.fullName,
                                nickname: characterResponse.nickname,
                                hogwartsHouse: characterResponse.hogwartsHouse,
                                interpretedBy: characterResponse.interpretedBy,
                                children: characterResponse.children,
                                image: try? await fetchImage(from: characterResponse.image ?? ""),
                                birthdate: characterResponse.birthdate,
                                index: characterResponse.index)
      characters.append(character)
    }
    return characters
  }

  func fetchCharacters(in language: ServiceLanguage) async throws -> [Character] {
    let response: [CharacterResponse] = try await fetch(.characters, in: language)
    return await mapCharacters(from: response)
  }

  func fetchBooks(in language: ServiceLanguage) async throws -> [Book] {
    let response: [BookResponse] = try await fetch(.books, in: language)
    return await mapBooks(from: response)
  }

  private func mapBooks(from response: [BookResponse]) async -> [Book] {
    var books: [Book] = []
    for bookResponse in response {
      async let image = fetchImage(from: bookResponse.cover ?? "")
      let book: Book = Book(number: bookResponse.number,
                            title: bookResponse.title,
                            originalTitle: bookResponse.originalTitle,
                            releaseDate: bookResponse.releaseDate,
                            description: bookResponse.description,
                            pages: bookResponse.pages,
                            cover: try? await image,
                            index: bookResponse.index)
      books.append(book)
    }
    return books
    }

}
