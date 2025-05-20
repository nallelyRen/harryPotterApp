//
//  AppColors.swift
//  harryPotterApp
//
//  Created by Nallely Rincon Contreras on 22/04/25.
//

import SwiftUI

enum AppColor {

    /// Fondo oscuro mágico (Azul oscuro) - #1E1B29
    static let magicalDarkBackground = Color(hex: "#1E1B29")

    /// Dorado encantado (Dorado antiguo) - #C4A000
    static let enchantedGold = Color(hex: "#C4A000")

    /// Tinta de pergamino (Beige pergamino) - #F5EEDC
    static let parchmentInk = Color(hex: "#F5EEDC")

    /// Acabado mágico (Gris metálico) - #A6A6A6
    static let magicalFinish = Color(hex: "#A6A6A6")

    /// Rojo Gryffindor (Rojo profundo) - #7F0909
    static let gryffindorRed = Color(hex: "#7F0909")

    /// Verde Slytherin (Verde esmeralda oscuro) - #0D4F2B
    static let slytherinGreen = Color(hex: "#0D4F2B")

    /// Azul Ravenclaw (Azul medianoche) - #222F5B
    static let ravenclawBlue = Color(hex: "#222F5B")

    /// Amarillo Hufflepuff (Amarillo cálido) - #EEE117
    static let hufflepuffYellow = Color(hex: "#EEE117")
}

enum HouseBackgrounds {
  /// Gryffindor - Rojo profundo a dorado
      static let gryffindor = LinearGradient(
          colors: [AppColor.gryffindorRed, AppColor.enchantedGold],
          startPoint: .topLeading,
          endPoint: .bottomTrailing
      )

      /// Slytherin - Verde esmeralda a gris metálico
      static let slytherin = LinearGradient(
          colors: [AppColor.slytherinGreen, AppColor.magicalFinish],
          startPoint: .topLeading,
          endPoint: .bottomTrailing
      )

      /// Ravenclaw - Azul medianoche a gris metálico
      static let ravenclaw = LinearGradient(
          colors: [AppColor.ravenclawBlue, AppColor.magicalFinish],
          startPoint: .topLeading,
          endPoint: .bottomTrailing
      )

      /// Hufflepuff - Amarillo cálido a beige pergamino
      static let hufflepuff = LinearGradient(
          colors: [AppColor.hufflepuffYellow, AppColor.parchmentInk],
          startPoint: .topLeading,
          endPoint: .bottomTrailing
      )
}
