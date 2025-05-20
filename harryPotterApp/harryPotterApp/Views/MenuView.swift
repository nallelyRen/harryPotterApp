//
//  MenuView.swift
//  harryPotterApp
//
//  Created by Nallely Rincon Contreras on 02/04/25.
//

import SwiftUI

struct Option: Identifiable, Hashable {
  let id = UUID()
  let title: String
  let color: Color
  let iconName: String
}

struct MenuView: View {
  @StateObject var viewModel: MenuViewModel
  @State private var selectedOption: String? = nil
  let columns = [GridItem(.flexible()), GridItem(.flexible())]

  var body: some View {
      TabView {
        ForEach(viewModel.menuOptions) { option in
          Tab (option.title, systemImage: option.iconName) {
            NavigationStack {
              getViewForTab(option.title)
            }
          }
        }
      }
  }

  @ViewBuilder
  func getViewForTab(_ tab: String) -> some View {
    switch tab {
            case "Libros":
              BookListView()
            case "Personajes":
              CharacterListView()
            case "Hechizos":
              SpellListView()
            default:
              EmptyView()
            }
  }
}

#Preview {
  MenuView(viewModel: MenuViewModel(repository: AsyncRepository(mainUrl: "https://potterapi-fedeperin.vercel.app")))
}
