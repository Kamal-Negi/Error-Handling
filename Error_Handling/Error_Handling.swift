//
//  Error_Handling.swift
//  Error_Handling
//
//  Created by Kamal Negi on 14/09/23.
//

import Foundation
import UIKit

struct ErrorViewState {
    var errorMessage: String  = ""
    var errorViewImage: String = ""
    var errorViewBackgroundColor: UIColor = .white
    var crossButtonImage: String = ""
    var crossButtonAction: (()->())?
    var errorType: ErrorType = .displayAndDisapper
    var animationDuration: Double = 2
    var disapperingDuration: Double = 5
    var errorLabelColor: UIColor = .white
    var errorLabelFont: UIFont = .systemFont(ofSize: 12)
    var alignement: ErrorAlignement = .center
}

enum ErrorType {
    case persistant
    case displayAndDisapper
    case userInteraction
}

enum ErrorAlignement {
    case top
    case center
}

class ErrorHandling: UIView {
    
    @IBOutlet weak var errorViewStackView: UIStackView!
    
    @IBOutlet weak var errorImageView: UIImageView!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    @IBOutlet weak var crossButton: UIButton!
    
    var errorState = ErrorViewState()
    
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
        let view = Bundle.main.loadNibNamed("Error_Handling", owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        animateErrorView()
    }
    
    func configureView() {
        errorMessageLabel.text = errorState.errorMessage
        errorMessageLabel.font = errorState.errorLabelFont
        errorMessageLabel.textColor = errorState.errorLabelColor
        errorImageView.image = UIImage(named: errorState.errorViewImage)
        crossButton.setTitle("", for: .normal)
        crossButton.setImage(UIImage(named: errorState.crossButtonImage), for: .normal)
        crossButton.addTarget(self, action: #selector(crossButtonTapped), for: .touchUpInside)
        errorViewStackView.backgroundColor = errorState.errorViewBackgroundColor
        
//        errorViewStackView.alignment = errorState.
    }
    
    @objc func crossButtonTapped() {
        if let crossButtonTap = errorState.crossButtonAction {
            crossButtonTap()
        }
    }
    
    func animateErrorView() {
        let newViewWidth = 0
        UIView.animate(withDuration: errorState.animationDuration) {
            self.errorViewStackView.frame = CGRect(x: 0, y: 0, width: newViewWidth, height: newViewWidth)
            self.errorViewStackView.center = self.center
        }
    }
    
    func disapperViewAnimation() {
        UIView.animate(withDuration: errorState.disapperingDuration) {
            self.isHidden = true
        } completion: { _ in
            self.crossButtonTapped()
        }

    }
    
}
