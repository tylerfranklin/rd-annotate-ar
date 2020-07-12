//
//  AnnotationService.swift
//  AnnotateAR
//
//  Created by Tyler Franklin on 3/30/20.
//  Copyright © 2020 Tyler Franklin. All rights reserved.
//

import CodableFirebase
import FirebaseAuth
import FirebaseFirestore
import Foundation

struct User: Codable {
    var userId: String?
    var userName: String
    var deviceToken: String? = ""
}

class AnnotationService {
    func saveNewUser(deviceToken: String?, callback: ((_ success: Bool) -> Void)?) {
        let userName = getCurrentUserName()
        let userId = Auth.auth().currentUser?.uid
        let newUser = try! FirestoreEncoder().encode(User(userId: userId, userName: userName, deviceToken: deviceToken))

        let firestore = Firestore.firestore()
        let userCollection = firestore.collection("users")

        let newUserReference = userCollection.document()

        firestore.runTransaction({ (transaction, _) -> Any in
            transaction.setData(newUser, forDocument: newUserReference)
        }) { _, error in
            if error != nil {
                callback?(false)
                return
            }

            callback?(true)
        }
    }

    private func getCurrentUserName() -> String {
        let user = Auth.auth().currentUser
        return user?.displayName ?? ""
    }
}
