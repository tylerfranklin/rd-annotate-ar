//
//  AnnotationDetailViewController.swift
//  AnnotateAR
//
//  Created by Tyler Franklin on 3/30/20.
//  Copyright © 2020 Tyler Franklin. All rights reserved.
//

import FirebaseAuth
import FirebaseFirestore
import UIKit

class AnnotationDetailViewController: ViewController<AnnotationDetailViewModel> {
    @IBOutlet var annotationIcon: UIImageView!
    @IBOutlet var collectAnnotationButtonView: UIView!
    @IBOutlet var collectorsTableView: UITableView!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var bookLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var pageLabel: UILabel!
    @IBOutlet var bodyLabel: UITextView!

    @IBOutlet var collectAnnotationLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    private let tableViewAdapter = TableViewAdapter<User>()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.ready()
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
        viewModel.stopObserving()
    }

    private func bindViewModel() {
        viewModel.didChangeData = { [weak self] data in
            guard let strongSelf = self else { return }
            if data.isUserACollector {
                strongSelf.disableButton()
            }

            let annotation = data.annotation
            // TODO: get the user from a user id
            strongSelf.authorLabel.text = annotation.owner
            strongSelf.bookLabel.text = annotation.book
            strongSelf.bodyLabel.text = annotation.body
            strongSelf.pageLabel.text = "(p\(annotation.page))"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short

            strongSelf.dateLabel.text = dateFormatter.string(from: annotation.date.dateValue())
            
            strongSelf.tableViewAdapter.update(with: data.collectors)
            strongSelf.collectorsTableView.reloadData()
        }

        collectorsTableView.dataSource = tableViewAdapter
        collectorsTableView.delegate = tableViewAdapter
        activityIndicator.isHidden = true

        tableViewAdapter.cellFactory = { tableView, _, cellData in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
            cell.textLabel?.text = cellData.userName
            return cell
        }

        let gesture = UITapGestureRecognizer(target: self, action: #selector(collectPressed))
        collectAnnotationButtonView.addGestureRecognizer(gesture)

        viewModel.collectAnnotationRequestCompleted = { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.activityIndicator.isHidden = true
            strongSelf.collectAnnotationLabel.isHidden = false
        }
    }

    private func disableButton() {
        collectAnnotationButtonView.backgroundColor = UIColor.gray
        collectAnnotationButtonView.isUserInteractionEnabled = false
    }

    @objc func collectPressed(sender _: UITapGestureRecognizer) {
        viewModel.collectAnnotation()
        activityIndicator.isHidden = false
        collectAnnotationLabel.isHidden = true
    }
}
