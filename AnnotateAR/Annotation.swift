//
//  Annotation.swift
//  AnnotateAR
//
//  Created by Tyler Franklin on 3/30/20.
//  Copyright © 2020 Tyler Franklin. All rights reserved.
//

import CodableFirebase
import Firebase

struct Annotation: Codable {
    var body: String
    var book: String
    var owner: String
    var page: Int
    var target: String
    var date: Timestamp
}
