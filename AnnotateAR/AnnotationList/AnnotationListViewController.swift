//
//  AnnotationListViewController.swift
//  AnnotateAR
//
//  Created by Tyler Franklin on 3/29/20.
//  Copyright © 2020 Tyler Franklin. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseFirestore

class AnnotationListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var viewModel: AnnotationListViewModel!

    @IBOutlet weak var tableView: UITableView!
       private var selectedAnnotation: Annotation?
       @IBOutlet weak var createAnnotationButton: UIView!

       private var listener: ListenerRegistration?

       override func viewDidLoad() {
           super.viewDidLoad()

           viewModel.didChangeData = { [weak self] data in
               guard let strongSelf = self else { return }
               strongSelf.tableView.reloadData()
           }

           tableView.dataSource = self
           tableView.delegate = self
       }

       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           viewModel.observeQuery()
       }

       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           viewModel.stopObserving()
       }

       deinit {
           listener?.remove()
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AnnotationTableViewCell
           let annotation = viewModel.viewData.annotations[indexPath.row]
           cell.populate(annotation: annotation)
           return cell
       }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return viewModel.viewData.annotations.count
       }

       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
       }
}




    }
}
