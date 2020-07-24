//
//  CreateAnnotationViewModel.swift
//  AnnotateAR
//
//  Created by Tyler Franklin on 3/30/20.
//  Copyright © 2020 Tyler Franklin. All rights reserved.
//

import CodableFirebase
import FirebaseAuth
import FirebaseFirestore

class CreateAnnotationViewModel {
    var createAnnotationRequestCompleted: ((_ success: Bool) -> Void)?

    func saveNewAnnotation(body: String, book: String, page: Int, target: String, date: Timestamp) {
        let newAnnotation = try! FirestoreEncoder().encode(Annotation(
            body: body,
            book: book,
            owner: getCurrentUserName(),
            page: page,
            target: target,
            date: date
        ))

        let firestore = Firestore.firestore()
        let annotationCollection = firestore.collection("annotations")

        let newAnnotationReference = annotationCollection.document()

        firestore.runTransaction({ (transaction, _) -> Any in
            transaction.setData(newAnnotation, forDocument: newAnnotationReference)
        }) { [weak self] _, error in
            guard let strongSelf = self else { return }
            if let error = error {
                print(error)
                strongSelf.createAnnotationRequestCompleted?(false)
                return
            }

            strongSelf.createAnnotationRequestCompleted?(true)
        }
    }

    private func getCurrentUserName() -> String {
        let user = Auth.auth().currentUser
        return user?.displayName ?? ""
    }

}
