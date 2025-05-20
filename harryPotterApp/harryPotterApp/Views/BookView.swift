//
//  BookView.swift
//  harryPotterApp
//
//  Created by Nallely Rincon Contreras on 08/04/25.
//

import SwiftUI

struct BookView: View {
  var book: Book?
  var body: some View {
    ZStack {
      backgroundView
      mainView
        .padding(.top, 30)
    }
  }
  var backgroundView: some View {
    Group {
      if let cover = book?.cover {
        ZStack {
          Color(hex: "#F5EEDC")
            .ignoresSafeArea()
          VStack {
            Image(uiImage: cover)
              .resizable()
              .scaledToFit()
              .cornerRadius(10)
              .shadow(color: Color.black.opacity(0.7), radius: 10, x: 0, y: 5)
              .ignoresSafeArea(.all)
              .blur(radius: 4.5)
            Spacer()
          }
          Color.black.opacity(0.4)
            .ignoresSafeArea()
        }
      }
    }
  }


  var mainView: some View {
    VStack {
      if let cover = book?.cover {
        Image(uiImage: cover)
          .resizable()
          .scaledToFit()
          .cornerRadius(10)
          .shadow(color: Color.black.opacity(0.7), radius: 10, x: 0, y: 5)
          .ignoresSafeArea(.all)
          .frame(height: 300)
      }
      bookInfo
    }
  }

  var bookInfo: some View {
    VStack(alignment: .center, spacing: 20) {
      if let title = book?.title {
        Text(title)
          .font(.custom("Times New Roman", fixedSize: 32))
          .foregroundStyle(AppColor.parchmentInk)
          .italic()
          .shadow(color: Color.black.opacity(0.5),
                  radius: 8, x: 0, y: 4)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 20)
      }

      ScrollView(.vertical) {
        VStack(alignment: .leading, spacing: 10) {
          if let number = book?.number {
            Text("Número: \(number)")
              .font(.title3)
              .foregroundColor(AppColor.magicalDarkBackground)
          }

          if let date = book?.releaseDate {
            Text("Fecha de publicación: \(date)")
              .font(.title3)
              .foregroundColor(AppColor.magicalDarkBackground)

            Text("Descripción:")
              .font(.title2)
              .bold()
              .foregroundColor(AppColor.magicalDarkBackground)

          }

          Text(book?.description ?? "")
            .font(.body)
            .foregroundColor(AppColor.magicalDarkBackground)
            .padding(.top, 5)
            .lineLimit(nil) // Para permitir múltiples líneas
            .multilineTextAlignment(.leading)
            .padding(.horizontal, 5)
        }
        .padding(.top, 24)
        .padding(.horizontal, 20)

      }
      .background(Color(hex: "#F5EEDC")) // Fondo oscuro con opacidad
      .cornerRadius(30)
      .ignoresSafeArea(.all)
    }

  }
}

//#Preview {
//  BookView(viewModel: MenuViewModel(repository: AsyncRepository(mainUrl: "https://potterapi-fedeperin.vercel.app")))
//}
