//
//  AnnotationDetailViewData.swift
//  ARAnnotate
//
//  Created by Tyler Franklin on 3/30/20.
//  Copyright © 2020 Tyler Franklin. All rights reserved.
//

import FirebaseFirestore
import Foundation

struct AnnotationDetailViewData {
    var annotation: Annotation
    var annotationReference: DocumentReference
    var collectors: [User]
    var isUserACollector: Bool = false
}
