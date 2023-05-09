//
//  ViewController.swift
//  KeyboardView-Demo
//
//  Created by JINSEOK on 2023/05/09.
//

import UIKit
import SnapKit

class ViewControllerV2: UIViewController, KeyboardEvent {
        
    let textField = UITextField()
    let imageView = UIImageView()
    let nextTextField = UITextField()
    
    var verticalStack: UIStackView!
    
    var transformView: UIView { return self.view }

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupKeyboardEvent()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        removeKeyboardObserver()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func configUI() {
        self.view.backgroundColor = .lightGray
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "첫번째 텍스트 필드"
        
        imageView.image = UIImage(named: "life")
        imageView.contentMode = .scaleAspectFit
        
        nextTextField.borderStyle = .roundedRect
        nextTextField.placeholder = "두번째 텍스트 필드"
        
        verticalStack = UIStackView(arrangedSubviews: [textField, imageView, nextTextField])
        verticalStack.axis = .vertical
        verticalStack.distribution = .equalSpacing
    
        self.setupLayout()
    }
    
    private func setupLayout() {
        
        textField.snp.makeConstraints { $0.height.equalTo(50) }
        nextTextField.snp.makeConstraints { $0.height.equalTo(50) }
        
        self.view.addSubview(verticalStack)
        verticalStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(150)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }

}



