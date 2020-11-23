//
//  ViewController.swift
//  stackUICollectionDemo
//
//  Created by KennethWu on 2020/11/19.
//

import UIKit

class ViewController: UIViewController {

    //@IBOutlet weak var mainStackView: UIStackView!
    
    //var dataList: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.title = NSLocalizedString("REQUEST", comment: "")
        
        //setList(numberOfRow: 2)
        self.tableView.register(UINib.init(nibName: "ButtonsStackViewTableCell", bundle: nil), forCellReuseIdentifier: "ButtonsStackViewTableCell")
        
        self.reloadUI()
    }

    func reloadUI() {
        self.tableView.reloadData()
    }
    
    /*
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
    */
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonsStackViewTableCell", for: indexPath) as! ButtonsStackViewTableCell
        cell.delegate = self
        cell.configCell(titleText: "Demo", buttonTitles: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"])
        //cell.setString(self.requestUrl(forQR: true)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController : ButtonsStackViewTableCellDelegate {
    func buttonsStackViewTableCellDidChange(_ cell:ButtonsStackViewTableCell, text:String) {
        
        /*
        if Globals.isValidPhone(value: (text.trim())) {
            self.fromContact = ContactVO.init(phone: text.trim(), name: nil)
            
        } else if Globals.isValidEmail(testStr: (text.trim())) {
            self.fromContact = ContactVO.init(email: text.trim(), name: nil)
            
        } else {
            self.fromContact  = nil
        }
        */
        
        print(text)
        //self.tableView.reloadData()
    }
}

