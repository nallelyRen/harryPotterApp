//
//  LoaderView.swift
//  harryPotterApp
//
//  Created by Nallely Rincon Contreras on 29/04/25.
//

import Foundation
import SwiftUI
struct LoaderView: View {
  var body: some View {
    ProgressView()
      .tint(AppColor.enchantedGold)
      .frame(width: 150, height: 150)
     .scaleEffect(2.0)
  }
}
