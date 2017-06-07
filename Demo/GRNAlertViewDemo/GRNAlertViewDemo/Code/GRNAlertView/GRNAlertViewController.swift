//
//  GRNAlertViewController.swift
//  GRNAlertView
//
//  Created by Wojciech on 2017-06-05.
//  Copyright © 2017 Guarana. All rights reserved.
//

import UIKit

struct GRNAlertLayout {
    var titleFont: UIFont? = nil
    var subtitleFont: UIFont? = nil
    var messageFont: UIFont? = nil
    var buttonsFont: UIFont? = nil
    
    var tintColor: UIColor? = nil
    var cornerRadius: UIColor? = nil
}

struct GRNAlertContent {
    var title: String? = nil
    var subtitle: String? = nil
    var message: String? = nil
    var image: UIImage? = nil
}

class GRNAlertViewController: UIViewController {

    //MARK: Private properties
    @IBOutlet private weak var alertView: UIView!
    @IBOutlet private weak var backgroundView: UIView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var leftButton: GRNMaterialButton!
    @IBOutlet private weak var rightButton: GRNMaterialButton!
    
    // implement shadow
    
    //MARK: Public properties
    typealias GRNAlertHandler = (_ alertController: GRNAlertViewController) -> Void
//    init(content: GRNAlertContent, layout: GRNAlertLayout, leftButtonHandler: GRNAlertHandler, rightButtonHandler: GRNAlertHandler) {
//        
//    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

}

private extension GRNAlertViewController {
    
    // MARK: Config
    func configureView() {
        
    }
    
    @IBAction private func backgroundButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension GRNAlertViewController {
    enum BackgroundType {
        case `default`, transparentLight, transparentDark, blurred
    }
}
