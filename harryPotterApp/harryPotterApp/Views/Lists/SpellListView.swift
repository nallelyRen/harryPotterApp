//
//  SpellListView.swift
//  harryPotterApp
//
//  Created by Nallely Rincon Contreras on 24/04/25.
//

import Foundation
import SwiftUI

struct SpellListView: View {
  @StateObject var viewModel = SpellListViewModel()
  let columns = [GridItem(.flexible()), GridItem(.flexible())]
  
  var body: some View {
    ScrollView(.vertical) {
      if viewModel.isLoading {
        LoaderView()
      } else {
        LazyVGrid(columns: columns) {
          ForEach(viewModel.spells) { spell in
            Button {
              viewModel.showSpellInfo.toggle()
              viewModel.spellSelected = spell
            } label: {
              if let spellSelected = viewModel.spellSelected,
                 spellSelected.spell == spell.spell {
                Text((viewModel.showSpellInfo ? spell.use : spell.spell) ?? "")
                  .font(viewModel.showSpellInfo ? .headline : .title3)
              } else {
                Text(spell.spell ?? "")
              }
            }
            .font(.title3)
            .foregroundStyle(AppColor.magicalDarkBackground)
            .padding(.vertical, 60)
            .frame(maxWidth: .infinity)
            .background(AppColor.magicalFinish.opacity(Double.random(in: (0.2)...1)))
          }
        }
      }
    }
    .navigationTitle("Hechizos")
    .task {
      await viewModel.fetchSpells()
    }
  }
}
#Preview {
  NavigationStack {
    SpellListView()
  }
}
