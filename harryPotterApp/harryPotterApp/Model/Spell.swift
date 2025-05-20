//
//  Spell.swift
//  harryPotterApp
//
//  Created by Nallely Rincon Contreras on 02/04/25.
//
struct Spell: Decodable, Identifiable {
  var id: Int {
    index
  }
  let spell: String?
  let use: String?
  let index: Int
}
