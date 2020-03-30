//
//  AnnotationListViewData.swift
//  AnnotateAR
//
//  Created by Tyler Franklin on 3/29/20.
//  Copyright © 2020 Tyler Franklin. All rights reserved.
//

import Foundation

struct Annotation {
    var owner: String
    var place: String
    var timestamp: Date
    var title: String

    var dictionary: [String: Any] {
        return [
            "owner": owner,
            "place": place,
            "timestamp": timestamp,
            "title": title
        ]
    }
}
