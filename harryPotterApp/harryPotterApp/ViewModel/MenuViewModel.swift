//
//  MenuViewModel.swift
//  harryPotterApp
//
//  Created by Nallely Rincon Contreras on 08/04/25.
//

import Foundation
import UIKit
import SwiftUICore

final class MenuViewModel: ObservableObject {
  @Published var spell: Spell? = nil
  @Published var cover: UIImage? = nil
  @Published var characterImage: UIImage? = nil
  @Published var book: Book? = nil
  @Published var character: Character? = nil
  @Published var isBookListShowing: Bool = false
  let menuOptions = [
    Option(title: "Libros",
           color: Color(hex: "#222F5B"),
           iconName: "books.vertical"),
    Option(title: "Personajes",
           color: Color(hex: "#EEE117"),
           iconName: "person.3.sequence"),
    Option(title: "Hechizos",
           color: Color(hex: "#0D4F2B"),
           iconName: "text.book.closed"),
    Option(title: "Casas",
           color: Color(hex: "#7F0909"),
           iconName: "shield"),
    Option(title: "Random",
           color: Color(hex: "#222F5B"),
           iconName: "sparkles")
  ]
  private let repository: AsyncRepository

  init(repository: AsyncRepository) {
    self.repository = repository
  }


}
