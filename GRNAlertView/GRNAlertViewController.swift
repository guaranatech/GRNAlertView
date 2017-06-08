//
//  GRNAlertViewController.swift
//  GRNAlertView
//
//  Created by Wojciech on 2017-06-05.
//  Copyright © 2017 Guarana. All rights reserved.
//

import UIKit

struct GRNAlertLayout {
    var backgroundType: GRNAlertViewController.BackgroundType = .transparentDark
    var titleFont: UIFont = .boldSystemFont(ofSize: 17.0)
    var subtitleFont: UIFont = .systemFont(ofSize: 14.0)
    var messageFont: UIFont = .systemFont(ofSize: 16.0)
    var buttonsFont: UIFont = .boldSystemFont(ofSize: 16.0)
    var textColor: UIColor = .black
    var backgroundColor: UIColor = .white
    var cornerRadius: CGFloat = 8.0
    
    init(backgroundType: GRNAlertViewController.BackgroundType = .transparentDark,
         titleFont: UIFont = .boldSystemFont(ofSize: 17.0),
         subtitleFont: UIFont = .systemFont(ofSize: 14.0),
         messageFont: UIFont = .systemFont(ofSize: 16.0),
         buttonsFont: UIFont = .boldSystemFont(ofSize: 16.0),
         textColor: UIColor = .black,
         backgroundColor: UIColor = .white,
         cornerRadius: CGFloat = 8.0) {
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
    var title: String?
    var subtitle: String?
    var message: String?
    var image: UIImage?
    var firstButtonTitle: String?
    var secondButtonTitle: String?
    
    init(title: String? = nil,
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
    convenience init(content: GRNAlertContent,
         layout: GRNAlertLayout? = nil,
         firstButtonHandler: GRNAlertHandler? = nil,
         secondButtonHandler: GRNAlertHandler? = nil) {
        
        self.init(nibName: String(describing: GRNAlertViewController.self), bundle: Bundle(for: GRNAlertViewController.self))
        self.content = content
        self.layout = layout
        self.firstButtonHandler = firstButtonHandler
        self.secondButtonHandler = secondButtonHandler
    }
    convenience init(title: String, message: String? = nil) {
        let content = GRNAlertContent(title: "title", message: message)
        self.init(content: content)
    }
    
    //MARK: Private properties
    fileprivate var content: GRNAlertContent!
    fileprivate var layout: GRNAlertLayout?
    
    fileprivate var shadowAdded: Bool = false
    fileprivate var shadowLayer: CAShapeLayer!
    @IBOutlet fileprivate weak var alertView: UIView!
    @IBOutlet fileprivate weak var backgroundView: UIView!
    
    @IBOutlet fileprivate weak var contentStackView: UIStackView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var subtitleLabel: UILabel!
    @IBOutlet fileprivate weak var messageLabel: UILabel!
    @IBOutlet fileprivate weak var imageView: UIImageView!
    
    @IBOutlet fileprivate weak var firstButton: GRNMaterialButton!
    @IBOutlet weak var buttonsSeparator: UIView!
    @IBOutlet fileprivate weak var secondButton: GRNMaterialButton!
    
    fileprivate var backgroundType: BackgroundType = .transparentDark
    
    fileprivate var firstButtonHandler: GRNAlertHandler?
    fileprivate var secondButtonHandler: GRNAlertHandler?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewDidLayoutSubviews() {
        guard !shadowAdded else {return}
        addShadowLayer()
    }
    
    // MARK: Show/dismiss
    
    func show(on vc: UIViewController, completion: (() -> Void)? = nil) {
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async {
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
        configureContent()
        configureLayout()
        configureBackground()
        configureHandlers()
    }
    
    private func configureContent() {
        firstButton.title = content.firstButtonTitle ?? "OK"
        secondButton.title = content.secondButtonTitle
        titleLabel.text = content.title
        subtitleLabel.text = content.subtitle
        messageLabel.text = content.message
        imageView.image = content.image

        subtitleLabel.isHidden = content.subtitle == nil
        messageLabel.isHidden = content.message == nil
        imageView.isHidden = content.image == nil

        if content.image == nil {
            contentStackView.removeArrangedSubview(imageView)
        }

        secondButton.isHidden = content.secondButtonTitle == nil
        buttonsSeparator.isHidden = content.secondButtonTitle == nil
    }
    
    private func configureLayout() {
        if layout == nil {
            layout = GRNAlertLayout()
        }
        titleLabel.font = layout?.titleFont
        subtitleLabel.font = layout?.subtitleFont
        messageLabel.font = layout?.messageFont
        firstButton.font = layout?.buttonsFont
        secondButton.font = layout?.buttonsFont
        alertView.layer.cornerRadius = layout?.cornerRadius ?? 8.0
        backgroundType = layout?.backgroundType ?? .transparentDark
        alertView.backgroundColor = layout?.backgroundColor
        
        titleLabel.textColor = layout?.textColor
        subtitleLabel.textColor = layout?.textColor
        messageLabel.textColor = layout?.textColor
        
    }
    
    func addShadowLayer() {
        shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: alertView.frame, cornerRadius: 0).cgPath
        shadowLayer.fillColor = UIColor.clear.cgColor
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowLayer.shadowOpacity = 0.4
        shadowLayer.shadowRadius = alertView.layer.cornerRadius
        if let index = view.layer.sublayers?.index(of: alertView.layer) {
            view.layer.insertSublayer(shadowLayer, at: UInt32(index))
        }
        shadowAdded = true
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
        case .clear:
            backgroundView.backgroundColor = .clear
        case .transparentDark:
            backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.4)
        case .transparentLight:
            backgroundView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        }
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
        case clear, transparentLight, transparentDark
    }
}
