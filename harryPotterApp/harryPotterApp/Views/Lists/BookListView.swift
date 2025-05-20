//
//  BookListView.swift
//  harryPotterApp
//
//  Created by Nallely Rincon Contreras on 22/04/25.
//

import SwiftUI

struct BookListView: View {
  @StateObject var viewModel = BookListViewModel()
  @State private var selectedOption: Book? = nil
  @State private var bookDetailIsActive: Bool = false

  var body: some View {
    NavigationStack {
      NavigationLink(destination: BookView(book: selectedOption), isActive: $bookDetailIsActive, label: {})
      if viewModel.isLoading {
        LoaderView()
          .task {
            await viewModel.fetchBooks()
          }
          .alert("Ha ocurrido un error",
                 isPresented: $viewModel.errorAlertIsActive) {
            Button("Reintentar") {
              Task {
                await viewModel.fetchBooks()
              }
            }
          }
      } else {
        ScrollView {
          VStack(spacing:10) {
            if viewModel.searchText.isEmpty {
              bookList(books: viewModel.books)
            } else {
              bookList(books: viewModel.filteredBooks)
            }
          }
        }
        .searchable(text: $viewModel.searchText)
        .navigationTitle("Libros")
      }


    }
  }

  private func bookList(books: [Book]) -> some View {
    ForEach(books) { book in
      bookRow(book: book)
        .onTapGesture {
          selectedOption = book
          bookDetailIsActive = true
        }
    }
  }

  private func bookRow(book: Book) -> some View {
    HStack {
      if let cover = book.cover {
        Image(uiImage: cover)
          .resizable()
          .scaledToFit()
          .frame(height: 100)
      }

      VStack(alignment:.leading, spacing: 10) {
        if let title = book.title {
          Text(title)
            .font(.headline)
        }
        if let title = book.number {
          Text("Libro \(title)")
            .font(.caption)
            .foregroundStyle(AppColor.enchantedGold)
        }
      }
      .padding(.trailing, 50)
      .padding(.leading, 10)
      .frame(maxWidth: .infinity, alignment: .leading)

    }
    .background(AppColor.magicalFinish.opacity(0.08))
  }
}

#Preview {
  NavigationStack {
    BookListView(viewModel: BookListViewModel())
  }
}
