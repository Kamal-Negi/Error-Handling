//
//  Error_Handling.swift
//  Error_Handling
//
//  Created by Kamal Negi on 14/09/23.
//

import Foundation
import UIKit

public enum ErrorType {
    case persistant
    case displayAndDisappear
    case userInteractionRequired
}

open class Error_Handling: UIView {
    
    private var contentView: UIView = UIView()
    
    private var parentView: UIView = UIView()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.axis = .horizontal
        return stackView
    } ()
    
    private var errorImageView: UIImageView = UIImageView()
    
    private var errorLabel: UILabel = UILabel()
    
    private var crossButton: UIButton = UIButton(type: .custom)
    
    public var alignement: UIStackView.Alignment = .center
    
    public var errorImage: String = ""
    
    public var errorMessage: String = ""
    
    public var errorMessageTextColor: UIColor = .black
    
    public var errorMessageFont: UIFont = .systemFont(ofSize: 12)
    
    public var crossButtonImage: String = ""
    
    public var viewBackground: UIColor = .white
    
    public var appearingAnimationDuration: CGFloat = 2
    
    public var disappearingAnimationDuration: CGFloat = 2
    
    public var crossButtonTap: (() -> ())?
    
    public var errorType: ErrorType = .persistant
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
    }
    
    private func setupViews() {
        //setup Content View
        contentView.frame = CGRect(x: 0, y: 70, width: self.frame.width, height: self.frame.height)
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(contentView)

        //setup Error Image
        errorImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        errorImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        stackView.addArrangedSubview(errorImageView)

        //setup Error Label
        errorLabel.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        errorLabel.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        errorLabel.numberOfLines = 0
        stackView.addArrangedSubview(errorLabel)

        //setup Cross Button
        crossButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
        crossButton.widthAnchor.constraint(equalToConstant: 18).isActive = true
        stackView.addArrangedSubview(crossButton)

        contentView.addSubview(parentView)
        parentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        parentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
    
        //added the constraint
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            parentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            parentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            parentView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            parentView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            parentView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 16),
            parentView.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            stackView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            stackView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(lessThanOrEqualTo: parentView.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: parentView.trailingAnchor, constant: -32)
        ])
    }
    
    public func configureView() {
        animateErrorView()
        
        stackView.alignment = alignement
        parentView.backgroundColor = viewBackground
        parentView.layer.cornerRadius = 2
        errorImageView.image = UIImage(named: errorImage)
        
        errorLabel.text = errorMessage
        errorLabel.textColor = errorMessageTextColor
        errorLabel.font = errorMessageFont
        
        crossButton.setTitle("", for: .normal)
        crossButton.setImage(UIImage(named: crossButtonImage), for: .normal)
        
        crossButton.addTarget(self, action: #selector(crossButtonTapped), for: .touchUpInside)
        
        switch errorType {
        case .persistant:
            crossButton.isHidden = true
            
        case .displayAndDisappear:
            crossButton.isHidden = true
            Timer.scheduledTimer(withTimeInterval: disappearingAnimationDuration, repeats: false) { _ in
                self.disappearingViewAnimation()
            }
            
        case .userInteractionRequired:
            crossButton.isHidden = crossButtonImage != "" ? false : true
        }
    }
    
    private func animateErrorView() {
        self.contentView.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: appearingAnimationDuration) {
            self.contentView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    @objc private func crossButtonTapped() {
        if let crossButtonTap = crossButtonTap {
            crossButtonTap()
        }
    }
    
    private func disappearingViewAnimation() {
        crossButtonTapped()
    }
}
