//
//  infoViewController.swift
//  eastCoastTrailApp
//
//  Created by Diego Zuluaga on 2017-04-28.
//  Copyright © 2017 Diego Zuluaga. All rights reserved.
//

import Foundation
import UIKit

class infoViewController: UIViewController {
    var titleString = ""
    var textString = ""
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = titleString
        infoArea.text = textString
        infoArea.backgroundColor = UIColor(white:1,alpha:0.7)
        titleLabel.backgroundColor = UIColor(white:1,alpha:0.7)
    }
}
