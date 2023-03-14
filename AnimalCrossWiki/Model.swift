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
}
