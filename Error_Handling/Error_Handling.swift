//
//  Error_Handling.swift
//  Error_Handling
//
//  Created by Kamal Negi on 14/09/23.
//

import Foundation
import UIKit

public struct ErrorState {
    public struct ErrorViewState {
        public var errorMessage: String  = ""
        public var errorViewImage: String = ""
        public var errorViewBackgroundColor: UIColor = .white
        public var crossButtonImage: String = ""
        public var crossButtonAction: (()->())?
        public var errorType: ErrorType = .displayAndDisapper
        public var animationDuration: Double = 2
        public var disapperingDuration: Double = 5
        public var errorLabelColor: UIColor = .white
        public var errorLabelFont: UIFont = .systemFont(ofSize: 12)
        public var alignement: UIStackView.Alignment = .center
        public var leadingSpace: CGFloat = 8
        public var trailingSpcae: CGFloat = 8
        public var topSpacing: CGFloat = 8
        public var bottomSpace: CGFloat = 8
        public var cornerRadius: CGFloat = 0
    }
    public var state = ErrorViewState()
}


public enum ErrorType {
    case persistant
    case displayAndDisapper
    case userInteraction
}

open class ErrorHandling: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var errorStackView: UIStackView!
    
    @IBOutlet weak var errorImageView: UIImageView!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    @IBOutlet weak var crossButton: UIButton!
    
    @IBOutlet weak var errorViewLeadingSpace: NSLayoutConstraint!
    
    @IBOutlet weak var errorViewTrailingSpace: NSLayoutConstraint!
    
    @IBOutlet weak var errorViewTopSpacing: NSLayoutConstraint!
    
    @IBOutlet weak var errorViewBottomSpacing: NSLayoutConstraint!
    
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    
    @IBOutlet weak var crossButtonHeight: NSLayoutConstraint!
    
    @IBOutlet weak var crossButtonWidth: NSLayoutConstraint!
    
    public var errorState = ErrorState()
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
       commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let view = Bundle(for: ErrorHandling.self).loadNibNamed("Error_Handling", owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        layoutSubviews()
        layoutIfNeeded()
    }
    
    public func configureView() {
        //animate view on load
        animateErrorView()
        
        //setup inital view
        errorMessageLabel.text = errorState.state.errorMessage
        errorMessageLabel.font = errorState.state.errorLabelFont
        errorMessageLabel.textColor = errorState.state.errorLabelColor
        errorImageView.image = UIImage(named: errorState.state.errorViewImage)
        crossButton.setTitle("", for: .normal)
        crossButton.setImage(UIImage(named: errorState.state.crossButtonImage), for: .normal)
        crossButton.addTarget(self, action: #selector(crossButtonTapped), for: .touchUpInside)
        contentView.layer.cornerRadius = errorState.state.cornerRadius
        errorStackView.alignment = errorState.state.alignement
        
        errorViewLeadingSpace.constant = errorState.state.leadingSpace
        errorViewTrailingSpace.constant = errorState.state.trailingSpcae
        errorViewTopSpacing.constant = errorState.state.topSpacing
        errorViewBottomSpacing.constant = errorState.state.bottomSpace
        
        switch errorState.state.errorType {
        case .persistant:
            crossButton.isHidden = true
        case .displayAndDisapper:
            crossButton.isHidden = true
            Timer.scheduledTimer(withTimeInterval: errorState.state.disapperingDuration, repeats: false, block: { _ in
                self.crossButtonTapped()
            })
        case .userInteraction:
            crossButton.isHidden = false
        }
        contentView.backgroundColor = errorState.state.errorViewBackgroundColor
        
    }
    
    public func setState(state: ErrorState) {
        errorState = state
    }
    
    @objc func crossButtonTapped() {
        if let crossButtonTap = errorState.state.crossButtonAction {
            crossButtonTap()
        }
    }
    
    func animateErrorView() {
        contentView.center = self.center
        self.contentView.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: errorState.state.animationDuration) {
            self.contentView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    func disapperViewAnimation() {
        crossButtonTapped()
    }
    
    public func setImageSize(width: CGFloat, height: CGFloat) {
        imageHeight.constant = height
        imageWidth.constant = width
    }
    
    public func setCrossButtonSize(width: CGFloat, height: CGFloat) {
        crossButtonHeight.constant = height
        crossButtonWidth.constant = width
    }
}
