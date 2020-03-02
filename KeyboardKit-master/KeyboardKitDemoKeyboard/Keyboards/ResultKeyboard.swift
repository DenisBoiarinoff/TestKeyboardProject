//
//  ResultKeyboard.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Денис Бояринов on 02/03/2020.
//

import Foundation
import KeyboardKit

struct ResultKeyboard: DemoKeyboard {
    
    init(in viewController: KeyboardViewController) {
//        actions = type(of: self).actions(in: viewController)
    }
    
//    let actions: KeyboardActionRows
  let toolbarActions: [KeyboardAction] = [
    .back
  ]
}
