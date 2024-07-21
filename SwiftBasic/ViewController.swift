//
//  ViewController.swift
//  SwiftBasic
//
//  Created by 李雪阳 on 2024/3/10.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    
    lazy var dataArray : [String] = {
        return ["基础语法练习","并发语法练习","响应式异步编程","功能方法总结"]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initTableView()
    }

    func initTableView() {
        self.tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), style:.plain)
        self.tableView.backgroundColor = .clear
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.separatorStyle = .none
        self.tableView.sectionFooterHeight = 0
        self.tableView.estimatedRowHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
        self.tableView.estimatedSectionFooterHeight = 0
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "tableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = self.dataArray[indexPath.row]
        cell?.textLabel?.textColor = .black
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(GrammarPracticeViewController(), animated: true)
        }else if indexPath.row == 1 {
            self.navigationController?.pushViewController(ConcurrencyPracticeViewController(), animated: true)
        }else if indexPath.row == 2 {
            self.navigationController?.pushViewController(CombineViewController(), animated: true)
        }else if indexPath.row == 3 {
            self.navigationController?.pushViewController(FunctionViewController(), animated: true)
        }
    }
}




func DPrint<T>(_ message: T, filePath: String = #file, function: String = #function, rowCount: Int = #line) {
    #if DEBUG
    let fileName = (filePath as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
//    print(fileName + "/ " + "\(rowCount)" + "/ " + "\(function)" + " ->:\n \(message)")
    print("class: <\(fileName) (第\(rowCount)行)> method: \(function) ->\n\(message)")
    
    /*
     let fileName = (file as NSString).lastPathComponent
     let functionStr = function.split(separator: "(").first
     print("\n**************自定义日志输出：\(fileName):\(functionStr ?? "")():[\(lineNumber)]************** \n\(message) \n**************************************************")
     **/
    #endif
}
