//
//  GRNAlertViewController.swift
//  GRNAlertView
//
//  Created by Wojciech on 2017-06-05.
//  Copyright © 2017 Guarana. All rights reserved.
//

import UIKit

struct GRNAlertLayout {
    var backgroundType: GRNAlertViewController.BackgroundType
    var titleFont: UIFont
    var subtitleFont: UIFont
    var messageFont: UIFont
    var buttonsFont: UIFont
    var textColor: UIColor
    var backgroundColor: UIColor
    var cornerRadius: CGFloat
    
    init(backgroundType: GRNAlertViewController.BackgroundType = .default,
         titleFont: UIFont = .boldSystemFont(ofSize: 17.0),
         subtitleFont: UIFont = .systemFont(ofSize: 14.0),
         messageFont: UIFont = .systemFont(ofSize: 16.0),
         buttonsFont: UIFont = .boldSystemFont(ofSize: 16.0),
         textColor: UIColor = .black,
         backgroundColor: UIColor = .white,
         cornerRadius: CGFloat = 0.0) {
        self.titleFont = titleFont
        self.subtitleFont = subtitleFont
        self.messageFont = messageFont
        self.buttonsFont = buttonsFont
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.backgroundType = backgroundType
    }
    
}

struct GRNAlertContent {
    var title: String
    var subtitle: String?
    var message: String?
    var image: UIImage?
    var firstButtonTitle: String?
    var secondButtonTitle: String?
    
    init(title: String,
         subtitle: String? = nil,
         message: String? = nil,
         image: UIImage? = nil,
         firstButtonTitle: String = "OK",
         secondButtonTitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.message = message
        self.image = image
        self.firstButtonTitle = firstButtonTitle
        self.secondButtonTitle = secondButtonTitle
    }
    
}

class GRNAlertViewController: UIViewController {

    //MARK: Public properties
    typealias GRNAlertHandler = (_ alertController: GRNAlertViewController) -> Void
    init(content: GRNAlertContent,
         layout: GRNAlertLayout? = nil,
         firstButtonHandler: GRNAlertHandler? = nil,
         secondButtonHandler: GRNAlertHandler? = nil) {
        
        super.init(nibName: "", bundle: Bundle(for: GRNAlertViewController.self))
        
        self.titleLabel.font = layout?.titleFont
        self.subtitleLabel.font = layout?.subtitleFont
        self.messageLabel.font = layout?.messageFont
        self.firstButton.font = layout?.buttonsFont
        self.secondButton.font = layout?.buttonsFont
        self.backgroundType = layout?.backgroundType ?? .default
        self.alertView.backgroundColor = layout?.backgroundColor
        
        self.firstButton.title = content.firstButtonTitle
        self.secondButton.title = content.secondButtonTitle
        self.titleLabel.text = content.title
        self.subtitleLabel.text = content.subtitle
        self.messageLabel.text = content.message
        self.imageView.image = content.image
        
        self.subtitleLabel.isHidden = content.subtitle == nil
        self.messageLabel.isHidden = content.message == nil
        
        self.secondButton.isHidden = secondButtonHandler == nil
        self.buttonsSeparator.isHidden = secondButtonHandler == nil
        
        self.firstButtonHandler = firstButtonHandler
        self.secondButtonHandler = secondButtonHandler
    }
    
    
    //MARK: Private properties
    fileprivate var shadowLayer: CAShapeLayer!
    @IBOutlet fileprivate weak var alertView: UIView!
    @IBOutlet fileprivate weak var backgroundView: UIView!
    
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var subtitleLabel: UILabel!
    @IBOutlet fileprivate weak var messageLabel: UILabel!
    @IBOutlet fileprivate weak var imageView: UIImageView!
    
    @IBOutlet fileprivate weak var firstButton: GRNMaterialButton!
    @IBOutlet weak var buttonsSeparator: UIView!
    @IBOutlet fileprivate weak var secondButton: GRNMaterialButton!
    
    fileprivate var backgroundType: BackgroundType = .default
    
    fileprivate var firstButtonHandler: GRNAlertHandler?
    fileprivate var secondButtonHandler: GRNAlertHandler?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: Show/dismiss
    
    func show(on vc: UIViewController, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async { 
            self.configureBackground()
            vc.present(self, animated: true, completion: completion)
        }
    }
    
    func dismiss(completion: (() -> Void)? = nil) {
        dismiss(animated: true, completion: completion)
    }
    
}

private extension GRNAlertViewController {
    
    // MARK: Config
    func configureView() {
        addShadowLayer()
    }

    private func addShadowLayer() {
        shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: alertView.frame, cornerRadius: 0).cgPath
        shadowLayer.fillColor = UIColor.clear.cgColor
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowLayer.shadowOpacity = 0.4
        shadowLayer.shadowRadius = alertView.layer.cornerRadius
        alertView.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    private func configureHandlers() {
        firstButton.tapHandler = {_ in
            if let handler = self.firstButtonHandler {
                handler(self)
            }
            self.dismiss(animated: true, completion: nil)
        }
        secondButton.tapHandler = {_ in
            if let handler = self.secondButtonHandler {
                handler(self)
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func configureBackground() {
        view.layoutIfNeeded()
        
        switch backgroundType {
        case .default:
            backgroundView.backgroundColor = .clear
        case .transparentDark:
            backgroundView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        case .transparentLight:
            backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.4)
        case .blurred:
            configureBlurredBackground()
        }
        
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }
    
    private func configureBlurredBackground() {
        let frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(view.bounds.size.width), height: CGFloat(view.bounds.size.height + 68))
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = frame
        view.frame = frame
        backgroundView.insertSubview(visualEffectView, at: 0)
        view.backgroundColor = UIColor.clear
        backgroundView.backgroundColor = UIColor.clear
    }
    
    // MARK: Actions
    
    @IBAction private func backgroundButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension GRNAlertViewController {
    enum BackgroundType {
        case `default`, transparentLight, transparentDark, blurred
    }
}
