//
//  Model.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/14.
//
import Foundation

struct AnimalModel: Codable,Hashable {
    var name: String
    var image_url: String
    var gender: String
    var species: String
    var birthday_month: String
    var birthday_day: String
}

struct Fish: Codable {
    var number: Int
    var image_url: String
    var name: String
    var sell_nook: Int
    var location: String
}

enum FishCase: String {
    case Pond = "Pond"
    case River = "River"
    case Sea = "Sea"
    case RiverClifftop = "River (clifftop)"
    case RiverMouth = "River (mouth)"
    case Pier = "Pier"
    case SeaRain = "Sea (raining)"
}

struct Bug: Codable {
    let image_url: String
    let name: String
    
}
