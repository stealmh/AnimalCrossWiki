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
