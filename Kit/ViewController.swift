//
//  ViewController.swift
//  Kit
//
//  Created by Stanislav Sobolevsky on 4.09.22.
//

import UIKit
import SnapKit

protocol TopViewDelegate: AnyObject {
    func textFieldEndEditing(_ textField: UITextField)
}

class TopView: UIView, UITextFieldDelegate{
    
    weak var delegate: TopViewDelegate?
    
    let horizontalStackView = UIStackView()
    let firastVerticalStackView = UIStackView()
    let secondVerticalStackView = UIStackView()
    let imageView = UIImageView(image: UIImage(named: "star"))
    let labelFirst = UILabel()
    let labelMiddle = UILabel()
    let labelLast = UILabel()
    let textFldFirst = UITextField()
    let textFldMiddle = UITextField()
    let textFldLast = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(horizontalStackView)
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 5
        horizontalStackView.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(self.snp.height)
        }
        horizontalStackView.addArrangedSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.height.equalTo(imageView.snp.width)
            make.height.equalTo(100)
        }
        horizontalStackView.addArrangedSubview(firastVerticalStackView)
        firastVerticalStackView.axis = .vertical
        firastVerticalStackView.distribution = .fillEqually
        firastVerticalStackView.addArrangedSubview(labelFirst)
        labelFirst.text = "First"
        firastVerticalStackView.addArrangedSubview(labelMiddle)
        labelMiddle.text = "Middle"
        firastVerticalStackView.addArrangedSubview(labelLast)
        labelLast.text = "Last"
        horizontalStackView.addArrangedSubview(secondVerticalStackView)
        firastVerticalStackView.snp.makeConstraints { make in
            make.width.equalTo(secondVerticalStackView.snp.width).multipliedBy(0.33)
        }
        secondVerticalStackView.axis = .vertical
        secondVerticalStackView.spacing = 3
        secondVerticalStackView.distribution = .fillEqually
        secondVerticalStackView.addArrangedSubview(textFldFirst)
        textFldFirst.placeholder = "First"
        textFldFirst.borderStyle = .roundedRect
        secondVerticalStackView.addArrangedSubview(textFldMiddle)
        textFldMiddle.placeholder = "Middle"
        textFldMiddle.borderStyle = .roundedRect
        secondVerticalStackView.addArrangedSubview(textFldLast)
        textFldLast.placeholder = "Last"
        textFldLast.borderStyle = .roundedRect
        
        textFldFirst.delegate = self
        textFldMiddle.delegate = self
        textFldLast.delegate = self
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldEndEditing(textField)
    }
}

class TextView: UIView {
    let textView = UITextView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        addSubview(textView)
        textView.text = "Notes..."
        textView.font = .systemFont(ofSize: 18)
        textView.backgroundColor = .none
        textView.isScrollEnabled = false
        textView.snp.makeConstraints { make in
                make.top.equalTo(self.snp.top).offset(10)
                make.bottom.equalTo(self.snp.bottom).offset(-10)
                make.left.equalTo(self.snp.left).offset(15)
                make.right.equalTo(self.snp.right).offset(-15)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol ButtonViewDelegate: AnyObject {
    func tapped(_ button: UIButton)
}

class ButtonView: UIView {
    
    weak var delegate: ButtonViewDelegate?
    
    let horizantolStackView = UIStackView()
    let buttonSave = UIButton()
    let buttonClear = UIButton()
    let buttonCancel = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(horizantolStackView)
        horizantolStackView.axis = .horizontal
        horizantolStackView.distribution = .fillEqually
        horizantolStackView.spacing = 5
        horizantolStackView.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(self.snp.height)
        }
        horizantolStackView.addArrangedSubview(buttonSave)
        buttonSave.setTitle("Save", for: .normal)
        buttonSave.setTitleColor(.link, for: .normal)
        horizantolStackView.addArrangedSubview(buttonClear)
        buttonClear.setTitle("Clear", for: .normal)
        buttonClear.setTitleColor(.link, for: .normal)
        horizantolStackView.addArrangedSubview(buttonCancel)
        buttonCancel.setTitle("Cancel", for: .normal)
        buttonCancel.setTitleColor(.link, for: .normal)
        
        buttonCancel.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        buttonClear.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        buttonSave.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped(_ button:UIButton){
        
        delegate?.tapped(button)
    }
}






class ViewController: UIViewController {
    let topView = TopView()
        let buttonView = ButtonView()
        let textView = TextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        topView.delegate = self
                buttonView.delegate = self
                
                self.view.addSubview(topView)
                self.view.addSubview(buttonView)
                self.view.addSubview(textView)
                topView.snp.makeConstraints { make in
                    make.left.equalTo(self.view.snp.left).offset(15)
                    make.top.equalTo(self.view.snp.top).offset(50)
                    make.right.equalTo(self.view.snp.right).offset(-15)
                }
                textView.snp.makeConstraints { make in
                    make.top.equalTo(topView.snp.bottom).offset(10)
                    make.bottom.equalTo(buttonView.snp.top).offset(-10)
                    make.left.equalTo(self.view.snp.left).offset(15)
                    make.right.equalTo(self.view.snp.right).offset(-15)
                }
                buttonView.snp.makeConstraints { make in
                    make.left.equalTo(self.view.snp.left).offset(15)
                    make.bottom.equalTo(self.view.snp.bottom).offset(-30)
                    make.right.equalTo(self.view.snp.right).offset(-15)
                }
               
                }
        }

        extension ViewController: TopViewDelegate{
            func textFieldEndEditing(_ textField: UITextField) {
                textView.textView.text = "Textfield did changed"
            }
        }

        extension ViewController : ButtonViewDelegate{
            func tapped(_ button: UIButton) {
                textView.textView.text.append("Button Press")
            }
            
            
        }
