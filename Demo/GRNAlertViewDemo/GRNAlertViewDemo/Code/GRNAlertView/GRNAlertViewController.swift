//
//  GRNAlertViewController.swift
//  GRNAlertView
//
//  Created by Wojciech on 2017-06-05.
//  Copyright © 2017 Guarana. All rights reserved.
//

import UIKit

class GRNAlertViewController: UIViewController {

    //MARK: Private properties
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    //MARK: Public properties
    typealias GRNAlertViewHandler = (alertController: GRNAlertViewController) -> Void
    init(title: String, subtitle: String, content: String, leftButtonTitle: String? = nil, rightButtonTitle: String? = nil, leftButtonHandler: ) {
        <#statements#>
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    // MARK: Config
    
    private func configureView() {
        
    }

}

extension AlertViewController {
    enum BackgroundType {
        case `default`, transparentLight, transparentDark, blurred
    }
}
