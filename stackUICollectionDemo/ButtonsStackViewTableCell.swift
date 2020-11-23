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

    //@IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainStackView: UIStackView!
    
    var buttons: [UIButton]?
    var initTag: Int = 888
    var numOfButton: Int = 0
    var dataList: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    //var dataList: [String] = []
    
    weak var delegate: ButtonsStackViewTableCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buttons = [UIButton]()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainStackView.removeSubviews()
    }
    
    func configCell(titleText: String, buttonTitles: [String] = [""]) {
        //let titles: [String] = buttonTitles
        
        //titleLabel.text = titleText
        
        dataList = buttonTitles
        setList(numberOfRow: 2)
        
        /*
        if dataList.count == 0 {
            dataList = buttonTitles
            setList(numberOfRow: 2)
        } else {
            let sorted1 = dataList.sorted()
            let sorted2 = titles.sorted()

            if sorted1 == sorted2 {
                print("data equal!")
            } else {
                print("data not equal")
                dataList = buttonTitles
                // rename title ?
                setList(numberOfRow: 2)
            }
        }
        */
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //self.backgroundColor = Color.pageBackgroundColor()
        //self.contentView.backgroundColor = Color.pageBackgroundColor()
    }
    
    func setList(numberOfRow: Int) {
        var currentStackView: UIStackView?
        //var standardButton: UIButton?
        
        for i in 0 ..< dataList.count {
            let data = dataList[i]
            let button = generateButton(title: data, index: i)
            
            if i.isMultiple(of: numberOfRow) {
                currentStackView = UIStackView(arrangedSubviews: [button])
                currentStackView?.distribution = .fillEqually
                currentStackView?.spacing = mainStackView.spacing
                mainStackView.addArrangedSubview(currentStackView!)
                
//                if i == 0 {
//                    currentStackView?.widthAnchor.constraint(equalTo: mainStackView.widthAnchor).isActive = true
//                }
            } else {
                currentStackView?.addArrangedSubview(button)
            }
            
            /*
            if let standardButton = standardButton {
                button.widthAnchor.constraint(equalTo: standardButton.widthAnchor).isActive = true
            } else {
                standardButton = button
            }
            */
        }
        
        if dataList.count % numberOfRow != 0 {
            let maxIndex = numberOfRow - (dataList.count % numberOfRow)
            for _ in 1...maxIndex {
                let view = UIView()
                view.backgroundColor = .clear
                currentStackView?.addArrangedSubview(view)
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
                    button.setTitleColor(UIColor.colorWithHex("4A4A4A", alpha: 1.0), for: .normal)
                    button.backgroundColor = UIColor.white
                }
            }
        }
        
        /*
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor = UIColor.azure
        */
        
        
        if let titleText = sender.titleLabel?.text {
            self.delegate?.buttonsStackViewTableCellDidChange(self, text: titleText)
        }
    }
    
    func generateButton(title: String, index: Int) -> UIButton {
        let myButton = UIButton(type: UIButton.ButtonType.custom)
        
        myButton.setTitle(title, for:.normal)
        myButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        myButton.alpha = 1
        // setting corner radius
        /*
        myButton.layer.borderColor = Fun88Color.colorWithHex("#F2F2F2", alpha: 1)!.cgColor
        myButton.layer.cornerRadius = 4
        myButton.layer.borderWidth = 1
        */
        // setting shadow
        myButton.layer.cornerRadius = 2
        myButton.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        myButton.layer.shadowOpacity = 1
        myButton.layer.shadowRadius = 0
        myButton.layer.shadowColor = #colorLiteral(red: 0.2980392157, green: 0.2980392157, blue: 0.2980392157, alpha: 0.21)
        
        myButton.setTitleColor(UIColor.colorWithHex("4A4A4A", alpha: 1.0), for: .normal)
        myButton.backgroundColor = UIColor.white
        //myButton.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 60) / 2, height: 44)
        myButton.tag = initTag + index
        
        print("myButton.tag=\(myButton.tag)!")
        
        myButton.addTarget(self, action: #selector(ButtonsStackViewTableCell.btnClickAction), for: .touchUpInside)
        myButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        /*
        if dataList.count == 1 {
            myButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        }
        */
        
        buttons?.append(myButton)
        return myButton
    }
}

public extension UIView {
    func removeSubviews() {
        subviews.forEach({$0.removeFromSuperview()})
    }
}

extension UIColor {
    static let azure: UIColor = UIColor(red: 0, green: 174, blue: 239, alpha: 1.0)
    
    static func colorWithHex(_ hexStr: String, alpha : Float) -> UIColor? {
        var hex = hexStr
        if (hex.isEmpty) { return nil };
        
        if (hex.hasPrefix("#")) {
            hex.remove(at: hex.startIndex)
        }
        
        if ((hex.count) != 6) {
            return UIColor.colorWithHex("00AEEF", alpha: 1.0)!;
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: hex).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
