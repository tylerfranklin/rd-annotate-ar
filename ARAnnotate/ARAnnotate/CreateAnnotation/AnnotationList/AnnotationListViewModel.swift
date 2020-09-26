//
//  AnnotationListViewModel.swift
//  ARAnnotate
//
//  Created by Tyler Franklin on 3/29/20.
//  Copyright © 2020 Tyler Franklin. All rights reserved.
//

import CodableFirebase
import FirebaseFirestore
import Foundation

class AnnotationListViewModel {
    var annotationsReference: DocumentReference?

    fileprivate var query: Query? {
        didSet {
            if let listener = listener {
                listener.remove()
                observeQuery()
            }
        }
    }

    private var listener: ListenerRegistration?
    var documents: [DocumentSnapshot] = []
    var didChangeData: ((AnnotationListViewData) -> Void)?

    var viewData: AnnotationListViewData {
        didSet {
            didChangeData?(viewData)
        }
    }

    init(viewData: AnnotationListViewData) {
        self.viewData = viewData
        query = baseQuery()
    }

    func observeQuery() {
        guard let query = query else { return }
        stopObserving()

        listener = query.addSnapshotListener { [unowned self] snapshot, error in

            guard let snapshot = snapshot else {
                print("Error fetching snapshot results: \(error!)")
                return
            }

            let models = snapshot.documents.compactMap { (document) -> Annotation? in
                do {
                    let model = try FirestoreDecoder().decode(Annotation.self, from: document.data())
                    return model
                } catch {
                    print("error parsing annotation: \(error) \(document.data())")
                    return nil
                }
            }
            self.viewData.annotations = models
            self.documents = snapshot.documents
        }
    }

    func stopObserving() {
        listener?.remove()
    }

    fileprivate func baseQuery() -> Query {
        return Firestore.firestore().collection("annotations").limit(to: 50)
    }
}
