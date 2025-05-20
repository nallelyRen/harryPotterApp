//
//  ContentView.swift
//  harryPotterApp
//
//  Created by Nallely Rincon Contreras on 02/04/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      MenuView(viewModel: MenuViewModel(repository: AsyncRepository()))
    }
}

#Preview {
    ContentView()
}
