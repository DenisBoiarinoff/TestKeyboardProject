//
//  ToolbarButton.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Денис Бояринов on 28/02/2020.
//

import Foundation
import KeyboardKit
import UIKit

class ToolbarButton: KeyboardButtonView {
  
  @IBOutlet weak var buttonTitle: UILabel! {
    didSet {
      buttonTitle?.text = ""
    }
  }
  @IBOutlet weak var buttonIcon: UIImageView!
  @IBOutlet weak var content: UIView!
    
  public func setup(
    with action: KeyboardAction,
    in viewController: KeyboardInputViewController,
    distribution: UIStackView.Distribution = .fillEqually
  ) {
    super.setup(with: action, in: viewController)
    backgroundColor = .clearTappable
    content?.backgroundColor = .clearTappable
    DispatchQueue.main.async {
      self.buttonIcon?.image = action.buttonImage
      self.buttonIcon.tintColor = action.tintColor(in: viewController)
    }
    buttonTitle?.text = action.buttonText
    buttonTitle?.textColor = action.tintColor(in: viewController)
    buttonTitle?.tintColor = action.tintColor(in: viewController)
    width = action.buttonWidth
  }
  
  
  
}

private extension KeyboardAction {
  
  var buttonImage: UIImage? {
    switch self {
      case .toolbar(let imageName, _):
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        return image
      case .back: return UIImage(named: "left-arrow")
      default: return nil
    }
  }
  
  var buttonText: String? {
    switch self {
      case .toolbar(_, let title): return title
      default: return nil
    }
  }
  
  func tintColor(in viewController: KeyboardInputViewController) -> UIColor {
    return UIColor(red: 58 / 255, green: 73 / 255, blue: 81 / 255, alpha: 1.0)
  }
  
  var buttonWidth: CGFloat {
    return 100.0
  }
  
}
