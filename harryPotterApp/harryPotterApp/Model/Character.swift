//
//  Character.swift
//  harryPotterApp
//
//  Created by Nallely Rincon Contreras on 22/04/25.
//

import Foundation
import UIKit
struct CharacterResponse: Decodable {
  var id: Int {
    index
  }
  let fullName: String?
  let nickname: String?
  let hogwartsHouse: String?
  let interpretedBy: String?
  let children: [String]?
  let image: String?
  let birthdate: String?
  let index: Int
}

struct Character: Identifiable, Hashable {
  var id: Int {
    index
  }
  let fullName: String?
  let nickname: String?
  let hogwartsHouse: String?
  let interpretedBy: String?
  let children: [String]?
  let image: UIImage?
  let birthdate: String?
  let index: Int
}
