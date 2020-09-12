//
//  ViewController.swift
//  AnnotateAR
//
//  Created by Tyler Franklin on 3/30/20.
//  Copyright © 2020 Tyler Franklin. All rights reserved.
//

import UIKit

public class ViewController<T>: UIViewController {
    var viewModel: T!

    public override func viewDidLoad() {
        super.viewDidLoad()
        if self is CreateAnnotationViewController
        { }
        else
        {
        assertViewModel()
        }
    }
}

private extension ViewController {
    func assertViewModel() {
        assert(viewModel != nil)
    }
}
