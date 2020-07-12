//  ViewController.swift
//  JSonServerCommunicatin in Swift
//  Created by Mac on 11/07/20.
//  Copyright © 2020 Gunde Ramakrishna Goud. All rights reserved.

import UIKit
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var Count: Int = 0
    var checkCount: Int = 0
    var data = [String]()
    var data1:[[String:Any]]!
    var data2:[[String:Any]]!
    override func viewDidLoad() {
        super.viewDidLoad()
        var outData = DataManager.shared.taskDetails(type: "https://demomaplebrains.ca/usva/api/services/waiverForms?appointment_services_id=1")
        print(outData)
        data1 = outData["service_terms_conditions"] as! [[String: Any]]
        data2 = data1[0]["terms_conditions"] as! [[String: Any]]
        for i in 0..<data2.count{
            data.append((data2![i]["terms_conditions"] as! String))
        }
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        var dataArr = data[indexPath.row]
        cell.label1.text = dataArr as! String
        cell.selectionStyle = .none
        cell.checkBoxBtn.addTarget(self, action: #selector(checkMarkButtonClicked(sender:)), for: .touchUpInside)
        return cell
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    }
    @objc func checkMarkButtonClicked(sender: UIButton)
    {
        if sender.isSelected{
            //uncheck the button
            sender.isSelected = false
            checkCount = checkCount - 1
             print("button unpresed")
        }else{
           //checkMark it
            sender.isSelected = true
            checkCount = checkCount + 1
            print("button presed")
        tableView.reloadData()
    }
    }
    @IBAction func onProceedBtn(_ sender: UIButton)
    {
        print(checkCount)
        if (checkCount == 5){
            let SVC = self.storyboard?.instantiateViewController(identifier: "SucessViewController") as! SucessViewController
            self.navigationController?.pushViewController(SVC, animated: true)

        }else {
            let alert = UIAlertController(title: "Oops", message: "Please Select Above CheckBox", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

