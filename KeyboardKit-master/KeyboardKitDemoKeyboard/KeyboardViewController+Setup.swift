//
//  KeyboardViewController+Setup.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import UIKit

extension KeyboardViewController {
    
    func setupKeyboard() {
        setupKeyboard(for: view.bounds.size)
    }
    
    func setupKeyboard(for size: CGSize) {
        DispatchQueue.main.async {
            self.setupKeyboardAsync(for: size)
        }
    }
    
    func setupKeyboardAsync(for size: CGSize) {
        keyboardStackView.removeAllArrangedSubviews()
        switch keyboardType {
        case .alphabetic(let uppercased): setupAlphabeticKeyboard(uppercased: uppercased)
        case .emojis: setupEmojiKeyboard(for: size)
        case .images: setupImageKeyboard(for: size)
        case .numeric: setupNumericKeyboard()
        case .symbolic: setupSymbolicKeyboard()
        case .custom(_): setupResultKeyboard()
        default: return
        }
    }
    
    func setupAlphabeticKeyboard(uppercased: Bool = false) {
      let keyboard = AlphabeticKeyboard(uppercased: uppercased, in: self)
      let rows = buttonRows(for: keyboard.actions, distribution: .fillProportionally)
      let toolbarConfig = KeyboardButtonRowCollectionView.Configuration(rowHeight: 40, rowsPerPage: 1, buttonsPerRow: 3)
      let toolbar = KeyboardButtonRowCollectionView(
        actions: keyboard.toolbarActions,
        configuration: toolbarConfig
      ) { (action) -> (UIView) in
        return self.toolbarButton(action: action)
      }
      keyboardStackView.addArrangedSubview(toolbar)
      keyboardStackView.addArrangedSubviews(rows)
    }
    
    func setupEmojiKeyboard(for size: CGSize) {
      let keyboard = EmojiKeyboard(in: self)
      let isLandscape = size.width > 400
      let rowsPerPage = isLandscape ? 4 : 5
      let buttonsPerRow = isLandscape ? 10 : 8
      let config = KeyboardButtonRowCollectionView.Configuration(
        rowHeight: 40,
        rowsPerPage: rowsPerPage,
        buttonsPerRow: buttonsPerRow)
      let view = KeyboardButtonRowCollectionView(
        actions: keyboard.actions,
        configuration: config
      ) { [unowned self] in
        return self.button(for: $0)
      }
      let bottom = buttonRow(for: keyboard.bottomActions, distribution: .fillProportionally)
      let toolbarConfig = KeyboardButtonRowCollectionView.Configuration(
        rowHeight: 40,
        rowsPerPage: 1,
        buttonsPerRow: 3)
      let toolbar = KeyboardButtonRowCollectionView(
        actions: keyboard.toolbarActions,
        configuration: toolbarConfig
      ) { (action) -> (UIView) in
        return self.toolbarButton(action: action)
      }
      keyboardStackView.addArrangedSubview(toolbar)
      keyboardStackView.addArrangedSubview(view)
      keyboardStackView.addArrangedSubview(bottom)
    }
    
    func setupImageKeyboard(for size: CGSize) {
      let keyboard = ImageKeyboard(in: self)
      let isLandscape = size.width > 400
      let rowsPerPage = isLandscape ? 3 : 4
      let buttonsPerRow = isLandscape ? 8 : 6
      let config = KeyboardButtonRowCollectionView.Configuration(
        rowHeight: 50,
        rowsPerPage: rowsPerPage,
        buttonsPerRow: buttonsPerRow)
      let view = KeyboardButtonRowCollectionView(
        actions: keyboard.actions,
        configuration: config
      ) { [unowned self] in
        return self.button(for: $0)
      }
      let bottom = buttonRow(for: keyboard.bottomActions, distribution: .fillProportionally)
      let toolbarConfig = KeyboardButtonRowCollectionView.Configuration(
        rowHeight: 40,
        rowsPerPage: 1,
        buttonsPerRow: 3)
      let toolbar = KeyboardButtonRowCollectionView(
        actions: keyboard.toolbarActions,
        configuration: toolbarConfig
      ) { (action) -> (UIView) in
          return self.toolbarButton(action: action)
      }
      keyboardStackView.addArrangedSubview(toolbar)
      keyboardStackView.addArrangedSubview(view)
      keyboardStackView.addArrangedSubview(bottom)
    }
    
    func setupNumericKeyboard() {
      let keyboard = NumericKeyboard(in: self)
      let rows = buttonRows(for: keyboard.actions, distribution: .fillProportionally)
      let toolbarConfig = KeyboardButtonRowCollectionView.Configuration(
        rowHeight: 40,
        rowsPerPage: 1,
        buttonsPerRow: 3)
      let toolbar = KeyboardButtonRowCollectionView(
        actions: keyboard.toolbarActions,
        configuration: toolbarConfig
      ) { (action) -> (UIView) in
          return self.toolbarButton(action: action)
      }
      keyboardStackView.addArrangedSubview(toolbar)
      keyboardStackView.addArrangedSubviews(rows)
    }
    
    func setupSymbolicKeyboard() {
      let keyboard = SymbolicKeyboard(in: self)
      let rows = buttonRows(for: keyboard.actions, distribution: .fillProportionally)
      let toolbarConfig = KeyboardButtonRowCollectionView.Configuration(
        rowHeight: 40,
        rowsPerPage: 1,
        buttonsPerRow: 3)
      let toolbar = KeyboardButtonRowCollectionView(
        actions: keyboard.toolbarActions,
        configuration: toolbarConfig
      ) { (action) -> (UIView) in
          return self.toolbarButton(action: action)
      }
      keyboardStackView.addArrangedSubview(toolbar)
      keyboardStackView.addArrangedSubviews(rows)
    }
  
  func setupResultKeyboard() {
    let keyboard = ResultKeyboard(in: self)
    let toolbarConfig = KeyboardButtonRowCollectionView.Configuration(
      rowHeight: 40,
      rowsPerPage: 1,
      buttonsPerRow: 3)
    let toolbar = KeyboardButtonRowCollectionView(
      actions: keyboard.toolbarActions,
      configuration: toolbarConfig
    ) { (action) -> (UIView) in
      return self.toolbarButton(action: action)
    }
    
    let config = KeyboardButtonRowCollectionView.Configuration(rowHeight: 50, rowsPerPage: 1, buttonsPerRow: 1)
    let view = KeyboardButtonRowCollectionView(
      actions: [.custom(name: "Result")],
      configuration: config
    ) { _ in
      let label = UILabel()
      label.text = ""
      
      let url = URL(string: "https://api.agendafacil.app/auth/getToken")!
      URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else { return }
        
        DispatchQueue.main.async {
          label.text = String(data: data, encoding: .utf8)
        }
      }.resume()
      
      return label
    }
    
    keyboardStackView.addArrangedSubview(toolbar)
    keyboardStackView.addArrangedSubview(view)
  }
}
