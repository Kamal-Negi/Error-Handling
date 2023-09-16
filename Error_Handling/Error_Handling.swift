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
    
    var parentStack: UIStackView = UIStackView()
    
    var stackView: UIStackView = UIStackView()
    
    var errorImageView: UIImageView = UIImageView()
    
    var errorLabel: UILabel = UILabel()
    
    var crossButton: UIButton = UIButton()
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(contentView)
        layoutSubviews()
        layoutIfNeeded()
        setupViews()
    }
    
    func setupViews() {
        
        parentStack.distribution = .fill
        parentStack.alignment = .center
        parentStack.axis = .vertical
        contentView.addSubview(parentStack)
       
        //setup Satck View
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        //setup Error Image
        errorImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        errorImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        stackView.addArrangedSubview(errorImageView)

        //setup Error Label
        errorLabel.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        errorLabel.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        stackView.addArrangedSubview(errorLabel)
        
        //setup Cross Button
        crossButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
        crossButton.widthAnchor.constraint(equalToConstant: 18).isActive = true
        stackView.addArrangedSubview(crossButton)
        
        parentStack.addSubview(stackView)
        parentStack.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            parentStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            parentStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            parentStack.heightAnchor.constraint(equalTo: stackView.heightAnchor, constant: 16),
            parentStack.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: 32*2),
            stackView.topAnchor.constraint(equalTo: parentStack.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: parentStack.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: parentStack.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(greaterThanOrEqualTo: parentStack.trailingAnchor, constant: 32),
        ])
    }
    
    func configureView() {
        animateErrorView()
        
        stackView.alignment = alignement
        parentStack.backgroundColor = viewBackground
        parentStack.layer.cornerRadius = 2
        errorImageView.image = UIImage(named: errorImage)
        
        errorLabel.text = errorMessage
        errorLabel.textColor = errorMessageTextColor
        errorLabel.font = errorMessageFontFamily
        
        crossButton.setTitle("", for: .normal)
        crossButton.setImage(UIImage(named: crossButtonImage), for: .normal)
        
        switch errorType {
        case .persistant:
            crossButton.isHidden = true
            
        case .displayAndDisapper:
            Timer.scheduledTimer(withTimeInterval: disappearingAnimationDuration, repeats: false) { _ in
                self.disapperViewAnimation()
            }
            
        case .userInteractionRequired:
            crossButton.isHidden = crossButtonImage != "" ? false : true
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: parentStack.leadingAnchor, constant: 8),
                stackView.trailingAnchor.constraint(equalTo: parentStack.trailingAnchor, constant: 8),
                parentStack.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: 8*2),
            ])
        }
    }
    
    func animateErrorView() {
        self.parentStack.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: animationDuration) {
            self.parentStack.transform = CGAffineTransform(scaleX: 1, y: 1)
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
