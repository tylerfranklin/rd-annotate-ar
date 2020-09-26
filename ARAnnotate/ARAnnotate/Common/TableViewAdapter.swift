//
//  TableViewAdapter.swift
//  ARAnnotate
//
//  Created by Tyler Franklin on 3/30/20.
//  Copyright © 2020 Tyler Franklin. All rights reserved.
//

import UIKit

class TableViewAdapter<T>: NSObject, UITableViewDataSource, UITableViewDelegate {
    typealias CellFactory = (UITableView, IndexPath, T) -> UITableViewCell

    var cellFactory: CellFactory!
    var didSelectItem: ((T, IndexPath) -> Void)?

    var data: [T] = []

    func update(with data: [T]) {
        self.data = data
    }

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = data[indexPath.row]
        return cellFactory(tableView, indexPath, cellData)
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = data[indexPath.row]
        didSelectItem?(cellData, indexPath)
    }
}
