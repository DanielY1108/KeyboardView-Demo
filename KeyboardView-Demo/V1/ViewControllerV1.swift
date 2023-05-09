//
//  ViewController.swift
//  KeyboardView-Demo
//
//  Created by JINSEOK on 2023/05/09.
//

import UIKit
import SnapKit

class ViewControllerV1: UIViewController {
    
    let textField = UITextField()
    let imageView = UIImageView()
    let nextTextField = UITextField()
    
    var verticalStack: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setupKeyboardEvent()
    }
    
    func setupKeyboardEvent() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        // keyboardFrame: 현재 동작하고 있는 이벤트에서 키보드의 frame을 받아옴
        // currentTextField: 현재 응답을 받고있는 UITextField를 알아냅니다.
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentResponder as? UITextField else { return }
        
        // Y축으로 키보드의 상단 위치
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        // 현재 선택한 텍스트 필드의 Frame 값
        let convertedTextFieldFrame = view.convert(currentTextField.frame,
                                                  from: currentTextField.superview)
        // Y축으로 현재 텍스트 필드의 하단 위치
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        // Y축으로 텍스트필드 하단 위치가 키보드 상단 위치보다 클 때 (즉, 텍스트필드가 키보드에 가려질 때가 되겠죠!)
        if textFieldBottomY > keyboardTopY {
            let textFieldTopY = convertedTextFieldFrame.origin.y
            // 노가다를 통해서 모든 기종에 적절한 크기를 설정함.
            let newFrame = textFieldTopY - keyboardTopY/1.6
            view.frame.origin.y -= newFrame
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func configUI() {
        self.view.backgroundColor = .darkGray
        
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

