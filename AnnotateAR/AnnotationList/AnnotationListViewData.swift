//
//  AnnotationListViewData.swift
//  AnnotateAR
//
//  Created by Tyler Franklin on 3/29/20.
//  Copyright © 2020 Tyler Franklin. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol DocumentSerializable {
    init?(dictionary: [String: Any])
}

struct Annotation: Codable {
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

extension Annotation: DocumentSerializable {

    init?(dictionary: [String : Any]) {
        guard let owner = dictionary["owner"] as? String,
            let place = dictionary["place"] as? String,
            let timestamp = dictionary["timestamp"] as? Date,
            let title = dictionary["title"] as? String
            else { return nil }

        self.init(owner: owner, place: place, timestamp: timestamp, title: title)
    }
}

struct AnnotationListViewData {
    var annotations: [Annotation]
}
