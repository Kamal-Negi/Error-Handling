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
        public var alignement: ErrorAlignement = .center
    }
    public var state = ErrorViewState()
}


public enum ErrorType {
    case persistant
    case displayAndDisapper
    case userInteraction
}

public enum ErrorAlignement {
    case top
    case center
}

open class ErrorHandling: UIView {
    
    @IBOutlet weak var errorViewStackView: UIStackView!
    
    @IBOutlet weak var errorImageView: UIImageView!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    @IBOutlet weak var crossButton: UIButton!
    
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
        let view = Bundle.main.loadNibNamed("Error_Handling", owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        animateErrorView()
    }
    
    func configureView() {
        errorMessageLabel.text = errorState.state.errorMessage
        errorMessageLabel.font = errorState.state.errorLabelFont
        errorMessageLabel.textColor = errorState.state.errorLabelColor
        errorImageView.image = UIImage(named: errorState.state.errorViewImage)
        crossButton.setTitle("", for: .normal)
        crossButton.setImage(UIImage(named: errorState.state.crossButtonImage), for: .normal)
        crossButton.addTarget(self, action: #selector(crossButtonTapped), for: .touchUpInside)
        errorViewStackView.backgroundColor = errorState.state.errorViewBackgroundColor
    }
    
    @objc func crossButtonTapped() {
        if let crossButtonTap = errorState.state.crossButtonAction {
            crossButtonTap()
        }
    }
    
    func animateErrorView() {
        let newViewWidth = 0
        UIView.animate(withDuration: errorState.state.animationDuration) {
            self.errorViewStackView.frame = CGRect(x: 0, y: 0, width: newViewWidth, height: newViewWidth)
            self.errorViewStackView.center = self.center
        }
    }
    
    func disapperViewAnimation() {
        UIView.animate(withDuration: errorState.state.disapperingDuration) {
            self.isHidden = true
        } completion: { _ in
            self.crossButtonTapped()
        }

    }
    
}
