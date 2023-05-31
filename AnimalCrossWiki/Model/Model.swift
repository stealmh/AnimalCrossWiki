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

struct Bug: Codable, Equatable {
    static func == (lhs: Bug, rhs: Bug) -> Bool {
        return true
    }
    let image_url: String
    let name: String
    let north, south: Hemisphere
}

struct Hemisphere: Codable {
    let months: String
    let months_array: [Int]
}

struct Turnip: Codable {
    let minMaxPattern: [[Int]]
    let avgPattern: [Double]
    let minWeekValue: Int
    let preview: String
}

//MARK: - Creature
struct Creature: Codable {
    let name: String
    let number: Int
    let image_url: String
    let shadow_size: String
    let shadow_movement: String
    let sell_nook: Int
    let north: CreatureNorth
}

struct CreatureNorth: Codable {
    let availability_array: [AvailabilityArray]
    let times_by_month: [String: String]
    let months: String
    let months_array: [Int]
}

struct AvailabilityArray: Codable {
    let months: String
    let time: String
}
