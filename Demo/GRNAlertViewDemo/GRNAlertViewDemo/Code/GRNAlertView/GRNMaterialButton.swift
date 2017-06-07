//
//  GRNMaterialButton.swift
//  GRNAlertView
//
//  Created by Wojciech on 2017-06-05.
//  Copyright © 2017 Guarana. All rights reserved.
//

import UIKit

internal typealias GRNMaterialButtonTapHandler = (_ button: GRNMaterialButton) -> Void

internal class GRNMaterialButton: UIView {
    
    // MARK: Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    //MARK: Public properties
    var tapHandler: GRNMaterialButtonTapHandler? = nil
    var title: String? {
        set {
            titleLabel.text = newValue?.uppercased()
        }
        get {
            return titleLabel.text
        }
    }
    
    var font: UIFont? {
        set {
            titleLabel.font = newValue
        }
        get {
            return titleLabel.font
        }
    }
    
    //MARK: Private properties
    fileprivate var tapGestureRecognizer: UITapGestureRecognizer!
    fileprivate var titleLabel: UILabel!
    
}

// MARK: Private
fileprivate extension GRNMaterialButton {
    
    func configureView() {
        let color = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        titleLabel.textColor = color
        titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        addSubview(titleLabel)
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        addGestureRecognizer(tapGestureRecognizer)
        
        configureConstraints()
    }
    
    func configureConstraints() {
        let heightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60)
        addConstraint(heightConstraint)
        
        let widthConstraint = NSLayoutConstraint(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0)
        addConstraint(widthConstraint)

        // Center Vertically
        let centerYConstraint = NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        addConstraint(centerYConstraint)
        // Center Horizontally
        let centerXConstraint = NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        addConstraint(centerXConstraint)
    }
    
    // MARK: UIGestureRecognizer selector
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        animate(for: sender.location(in: self))
    }
    
    func animate(for tapPoint: CGPoint) {
        let roundView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(20), height: CGFloat(20)))
        roundView.backgroundColor = UIColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0), alpha: CGFloat(0.05))
        roundView.center = tapPoint
        roundView.layer.cornerRadius = 10.0
        addSubview(roundView)
        bringSubview(toFront: titleLabel)
        removeGestureRecognizer(tapGestureRecognizer)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { 
            roundView.transform = CGAffineTransform(scaleX: 50, y: 50)
            roundView.alpha = 0.5
        }) {[weak self] finished in
            guard let weakSelf = self else { return}
            if let handler = weakSelf.tapHandler {
                handler(weakSelf)
            }
            roundView.removeFromSuperview()
            weakSelf.addGestureRecognizer(weakSelf.tapGestureRecognizer)
        }
    }
    
}
