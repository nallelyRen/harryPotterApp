//
//  CharacterListView.swift
//  harryPotterApp
//
//  Created by Nallely Rincon Contreras on 24/04/25.
//

import SwiftUI

struct CharacterListView: View {
  @StateObject var viewModel = CharacterListViewModel()
  @State var isDetailViewActive: Bool = false

  var body: some View {
    if viewModel.isLoading {
      LoaderView()
        .task {
          await viewModel.fetchCharacters()
        }
    } else {
      ScrollView(.vertical) {
        if viewModel.searchText.isEmpty {
          characterList(characters: viewModel.characters)
        } else {
          characterList(characters: viewModel.filteredCharacters)
        }
      }
      .navigationTitle("Personajes")
      .searchable(text: $viewModel.searchText)
      .sheet(isPresented: $isDetailViewActive) {
        CharacterView(character: viewModel.characterSelected)
      }
    }
  }

  private func characterList(characters: [Character]) -> some View {
    VStack(spacing: 10) {
      ForEach(characters) { character in
        characterRow(character: character)
          .onTapGesture {
            viewModel.characterSelected = character
            isDetailViewActive = true
          }
      }
    }
  }

  private func characterRow(character: Character) -> some View {
    HStack {
      if let image = character.image {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
          .frame(height: 150)
          .cornerRadius(12)

      }
      VStack {
        if let name = character.fullName {
          Text(name)
            .font(.headline)
        }
      }
      .padding(.leading, 20)
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(.horizontal, 15)
    .background(AppColor.magicalFinish.opacity(0.08))
  }
}

#Preview {
  NavigationStack {
    CharacterListView()
  }
}
