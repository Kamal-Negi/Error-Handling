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
    case displayAndDisapper
    case userInteractionRequired
}

class Error_Handling: UIView {
    
    var contentView: UIView = UIView()
    
    var parentView: UIView = UIView()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.axis = .horizontal
        return stackView
    } ()
    
    var errorImageView: UIImageView = UIImageView()
    
    var errorLabel: UILabel = UILabel()
    
    var crossButton: UIButton = UIButton(type: .custom)
    
    public var alignement: UIStackView.Alignment = .center
    
    public var errorImage: String = ""
    
    public var errorMessage: String = ""
    
    public var errorMessageTextColor: UIColor = .black
    
    public var errorMessageFontFamily: UIFont = .systemFont(ofSize: 12)
    
    public var crossButtonImage: String = ""
    
    public var viewBackground: UIColor = .white
    
    public var animationDuration: CGFloat = 2
    
    public var disappearingAnimationDuration: CGFloat = 2
    
    public var crossButtonTap: (() -> ())?
    
    public var errorType: ErrorType = .displayAndDisapper
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
    }
    

    
    func setupViews() {
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
            parentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            parentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
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
        errorLabel.font = errorMessageFontFamily
        
        crossButton.setTitle("", for: .normal)
        crossButton.setImage(UIImage(named: crossButtonImage), for: .normal)
        
        crossButton.addTarget(self, action: #selector(crossButtonTapped), for: .touchUpInside)
        
        switch errorType {
        case .persistant:
            crossButton.isHidden = true
            
        case .displayAndDisapper:
            crossButton.isHidden = true
            Timer.scheduledTimer(withTimeInterval: disappearingAnimationDuration, repeats: false) { _ in
                self.disapperViewAnimation()
            }
            
        case .userInteractionRequired:
            crossButton.isHidden = crossButtonImage != "" ? false : true
        }
    }
    
    func animateErrorView() {
        self.contentView.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: animationDuration) {
            self.contentView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    @objc func crossButtonTapped() {
        if let crossButtonTap = crossButtonTap {
            crossButtonTap()
        }
    }
    
    func disapperViewAnimation() {
        crossButtonTapped()
    }
}
