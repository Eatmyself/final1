//
//  userdata.swift
//  final1
//
//  Created by Eat Myself on 2021/6/29.
//

import Foundation
import FirebaseFirestoreSwift

struct Userdata: Codable, Identifiable {
    @DocumentID var id: String?
    let name: String
    let time: Date
    let face: Int
    let accessoriese: Int
    let bodyimg: Int
    let facial: Int
    let head: Int
}

