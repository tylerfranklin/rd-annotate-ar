//
//  AnnotationDetailViewModel.swift
//  ARAnnotate
//
//  Created by Tyler Franklin on 3/30/20.
//  Copyright © 2020 Tyler Franklin. All rights reserved.
//

import CodableFirebase
import FirebaseAuth
import FirebaseFirestore
import Foundation

class AnnotationDetailViewModel {
    var didChangeData: ((AnnotationDetailViewData) -> Void)?
    var annotationReference: DocumentReference?
    var collectAnnotationRequestCompleted: ((_ success: Bool) -> Void)?

    fileprivate var query: CollectionReference? {
        didSet {
            if let listener = listener {
                listener.remove()
                observeQuery()
            }
        }
    }

    private var listener: ListenerRegistration?
    var documents: [DocumentSnapshot] = []

    var viewData: AnnotationDetailViewData {
        didSet {
            didChangeData?(viewData)
        }
    }

    init(viewData: AnnotationDetailViewData) {
        self.viewData = viewData
        annotationReference = viewData.annotationReference
        query = baseQuery()
    }

    func ready() {
        didChangeData?(viewData)
    }

    func observeQuery() {
        guard let query = query else { return }
        stopObserving()

        listener = query.addSnapshotListener { [unowned self] snapshot, error in
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results: \(error!)")
                return
            }

            let models = snapshot.documents.compactMap { (document) -> User? in
                do {
                    let model = try FirestoreDecoder().decode(User.self, from: document.data())
                    return model
                } catch {
                    print("error parsing document: \(document.data())")
                    return nil
                }
            }

            self.viewData.collectors = models
            self.canTheUserCollectTheAnnotation()
            self.documents = snapshot.documents
        }
    }

    func stopObserving() {
        listener?.remove()
    }

    fileprivate func baseQuery() -> CollectionReference? {
        return annotationReference?.collection("collectors")
    }

    func collectAnnotation() {
        guard let query = query else { return }

        let user = Auth.auth().currentUser

        let passenger = try! FirestoreEncoder().encode(User(userId: user?.uid, userName: (user?.displayName)!, deviceToken: nil))

        let newCollectorReference = query.document()

        Firestore.firestore().runTransaction({ (transaction, _) -> Any in
            transaction.setData(passenger, forDocument: newCollectorReference)
        }) { [weak self] _, error in
            guard let strongSelf = self else { return }
            if let error = error {
                print(error)
                strongSelf.collectAnnotationRequestCompleted?(false)
                return
            }

            strongSelf.collectAnnotationRequestCompleted?(true)
        }
    }
    
    private func canTheUserCollectTheAnnotation() {
        let userId = Auth.auth().currentUser?.uid
        let author = viewData.annotation.owner

        let users = viewData.collectors.filter { passenger in
            passenger.userId == userId || passenger.userId == author
        }

        viewData.isUserACollector = users.count == 1
    }
}
