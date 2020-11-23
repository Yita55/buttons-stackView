//
//  ButtonsStackViewTableCell.swift
//  stackUICollectionDemo
//
//  Created by KennethWu on 2020/11/23.
//

import UIKit

protocol ButtonsStackViewTableCellDelegate: class {
    func buttonsStackViewTableCellDidChange(_ cell:ButtonsStackViewTableCell, text:String)
}

class ButtonsStackViewTableCell: UITableViewCell {

    @IBOutlet weak var mainStackView: UIStackView!
    
    var buttons: [UIButton]?
    var initTag: Int = 888
    var dataList: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    weak var delegate: ButtonsStackViewTableCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buttons = [UIButton]()
        setList(numberOfRow: 2)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //self.backgroundColor = Color.pageBackgroundColor()
        //self.contentView.backgroundColor = Color.pageBackgroundColor()
        //setList(numberOfRow: 2)
    }
    
    func setList(numberOfRow: Int) {
        var currentStackView: UIStackView?
        var standardButton: UIButton?
        
        for i in 0..<dataList.count {
            let data = dataList[i]
            let button = generateButton(title: data, index: i)
            
            if i.isMultiple(of: numberOfRow) {
                currentStackView = UIStackView(arrangedSubviews: [button])
                currentStackView?.spacing = mainStackView.spacing
                mainStackView.addArrangedSubview(currentStackView!)
            } else {
                currentStackView?.addArrangedSubview(button)
                
                if i % numberOfRow == numberOfRow - 1 {
                    currentStackView?.widthAnchor.constraint(equalTo: mainStackView.widthAnchor).isActive = true
                }
            }
            
            if let standardButton = standardButton {
                button.widthAnchor.constraint(equalTo: standardButton.widthAnchor).isActive = true
            } else {
                standardButton = button
            }
        }
    }
    
    @objc func btnClickAction(_ sender: UIButton) {
        DispatchQueue.main.async {
            for (_, button) in self.buttons!.enumerated() {
                if sender.tag == button.tag {
                    button.setTitleColor(UIColor.white, for: .normal)
                    button.backgroundColor = UIColor.systemBlue
                } else {
                    button.setTitleColor(UIColor.black, for: .normal)
                    button.backgroundColor = UIColor.white
                }
            }
        }
                
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor = UIColor.systemBlue
        
        if let titleText = sender.titleLabel?.text {
            self.delegate?.buttonsStackViewTableCellDidChange(self, text: titleText)
        }
    }
    
    func generateButton(title: String, index: Int) -> UIButton {
        let myButton = UIButton(type: UIButton.ButtonType.custom)
        
        myButton.setTitle(title, for:.normal)
        myButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        myButton.alpha = 1
        myButton.layer.borderColor = UIColor.white.cgColor
        myButton.layer.cornerRadius = 4
        myButton.layer.borderWidth = 1
        myButton.setTitleColor(UIColor.black, for: .normal)
        myButton.backgroundColor = UIColor.white
        //myButton.frame = CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.size.width - 20) / 2, height: 200)
        myButton.tag = initTag + index
        myButton.addTarget(self, action: #selector(ButtonsStackViewTableCell.btnClickAction), for: .touchUpInside)
        
        buttons?.append(myButton)
        return myButton
    }
}
