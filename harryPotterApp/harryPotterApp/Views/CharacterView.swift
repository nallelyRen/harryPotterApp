//
//  CharacterView.swift
//  harryPotterApp
//
//  Created by Nallely Rincon Contreras on 22/04/25.
//

import SwiftUI

struct CharacterView: View {
  var character: Character?

    var body: some View {
      ZStack {
        mainView
          .padding(.top, 30)
      }
    }

  var backgroundView: some View {
    switch character?.hogwartsHouse {
    case "Gryffindor":
      return  HouseBackgrounds.gryffindor
    case "Hufflepuff":
      return  HouseBackgrounds.hufflepuff
    case "Ravenclaw":
      return  HouseBackgrounds.ravenclaw
    case "Slytherin":
      return  HouseBackgrounds.slytherin
    default:
      return  HouseBackgrounds.gryffindor
    }

  }


  var mainView: some View {
    VStack {
      if let cover = character?.image {
        Image(uiImage: cover)
          .resizable()
          .scaledToFit()
          .frame(height: 300)
          .clipShape(.capsule)
        // .offset(y: -200)
      }
      VStack {
        if let name = character?.fullName {
          Text(name)
            .font(.title)
        }
        if let fullName = character?.birthdate {
          Text(fullName)
            .font(.headline)
            .foregroundStyle(Color(AppColor.magicalDarkBackground))
        }
        Divider()
          .padding(.horizontal, 20)
        VStack(alignment: .leading) {
          Text("Interpretado por:" )
            .font(.headline)
            .foregroundStyle(Color(AppColor.magicalDarkBackground))
          if let fullName = character?.interpretedBy {
            Text(fullName)
              .font(.subheadline)
          }
          Text("Casa:" )
            .font(.headline)
            .foregroundStyle(Color(AppColor.magicalDarkBackground))
          if let house = character?.hogwartsHouse {
            Text(house)
              .font(.subheadline)
          }
          if let children = character?.children,
             !children.isEmpty {
            Text("Hijos:" )
              .font(.headline)
              .foregroundStyle(Color(AppColor.magicalDarkBackground))
            ForEach(children, id: \.self) { child in
              Text(child)
            }
          }
          Spacer()
            .frame(height: 200)
        }

      }
      .background(AppColor.magicalFinish.opacity(0.5).blur(radius: 1))
      .cornerRadius(12)
      .padding(.horizontal, 20)

    }
  }

}

//#Preview {
//  CharacterView(viewModel: MenuViewModel(repository: AsyncRepository(mainUrl: "https://potterapi-fedeperin.vercel.app")))
//}
