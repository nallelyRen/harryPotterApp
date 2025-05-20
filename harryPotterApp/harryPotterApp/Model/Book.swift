//
//  Book.swift
//  harryPotterApp
//
//  Created by Nallely Rincon Contreras on 02/04/25.
//

import Foundation
import UIKit

struct BookResponse: Decodable {
  let number: Int?
  let title: String?
  let originalTitle: String?
  let releaseDate: String?
  let description: String?
  let pages: Int?
  let cover: String?
  let index: Int

}

struct Book: Identifiable, Hashable {
  var id: Int {
    index
  }
  let number: Int?
  let title: String?
  let originalTitle: String?
  let releaseDate: String?
  let description: String?
  let pages: Int?
  let cover: UIImage?
  let index: Int
}
