//
//  ViewController.swift
//  stackUICollectionDemo
//
//  Created by KennethWu on 2020/11/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainStackView: UIStackView!
    
    var dataList: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setList(numberOfRow: 2)
    }

    func setList(numberOfRow: Int) {
        var currentStackView: UIStackView?
        var standardButton: UIButton?
        
        for i in 0..<dataList.count {
            let data = dataList[i]
            let button = generateButton(title: data)
            
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
    
    func generateButton(title: String) -> UIButton {
        let myButton = UIButton(type: UIButton.ButtonType.custom)
        
        myButton.setTitle(title, for:.normal)
        myButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        myButton.alpha = 1
        myButton.layer.borderColor = UIColor.systemBlue.cgColor
        myButton.layer.cornerRadius = 4
        myButton.layer.borderWidth = 1
        myButton.setTitleColor(UIColor.white, for: .normal)
        myButton.backgroundColor = UIColor.systemBlue
        //myButton.frame = CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.size.width - 20) / 2, height: 200)
        //myButton.tag = 888 + index
        //myButton.addTarget(self, action: action, for: .touchUpInside)
        return myButton
    }
}

