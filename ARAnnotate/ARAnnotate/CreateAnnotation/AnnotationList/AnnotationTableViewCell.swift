//
//  AnnotationTableViewCell.swift
//  ARAnnotate
//
//  Created by Tyler Franklin on 3/30/20.
//  Copyright © 2020 Tyler Franklin. All rights reserved.
//

import UIKit

class AnnotationTableViewCell: UITableViewCell {
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var userPlaceholderIcon: UIImageView!
    @IBOutlet var bookLabel: UILabel!
    @IBOutlet var pageLabel: UILabel!
    @IBOutlet var bodyText: UITextView!

    func populate(annotation: Annotation) {
        authorLabel.text = annotation.owner
        bookLabel.text = annotation.book
        pageLabel.text = "(p\(String(annotation.page)))"
        bodyText.text = annotation.body
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short

        dateLabel.text = dateFormatter.string(from: annotation.date.dateValue())
    }
}
