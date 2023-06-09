//
//  ViewControllerV3.swift
//  KeyboardView-Demo
//
//  Created by JINSEOK on 2023/06/09.
//

import UIKit

class ViewControllerV3: UIViewController {
    
    let textField = UITextField()
    let imageView = UIImageView()
    let nextTextField = UITextField()
    
    var verticalStack: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        // keyboardFrame: 현재 동작하고 있는 이벤트에서 키보드의 frame을 받아옴
        // currentTextField: 현재 응답을 받고있는 UITextField를 알아냅니다.
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentResponder as? UITextField else { return }
        
        
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
        self.view.backgroundColor = .systemOrange
        
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.placeholder = "첫번째 텍스트 필드"
        
        imageView.image = UIImage(named: "life")
        imageView.contentMode = .scaleAspectFit
        
        nextTextField.delegate = self
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

extension ViewControllerV3: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.textField {
            view.frame.origin.y = 0
            
        } else if textField == self.nextTextField {
            UIView.animate(withDuration: 0.3) {
                let transform = CGAffineTransform(translationX: 0, y: -200)
                self.view.transform = transform
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.textField {
            view.frame.origin.y = 0
            
        } else if textField == self.nextTextField {
            UIView.animate(withDuration: 0.3) {
                let transform = CGAffineTransform(translationX: 0, y: 0)
                self.view.transform = transform
            }
        }
    }
}
