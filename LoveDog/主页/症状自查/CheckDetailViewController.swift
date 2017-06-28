//
//  CheckDetailViewController.swift
//  LoveDog
//
//  Created by wei on 16/9/13.
//  Copyright © 2016年 wei. All rights reserved.
//

import UIKit

class CheckDetailViewController: UIViewController {

    var keyWord:String?
    
    var dataArr = NSMutableArray()
    var tableView: UITableView!//整个页面
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.keyWord
        self.view.backgroundColor = UIColor.white
        self.createTableView()
        self.loadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createTableView(){
        self.automaticallyAdjustsScrollViewInsets = false
        tableView = UITableView.init(frame: CGRect(x: 0, y: 64, width: SCREEN_W, height: SCREEN_H-64), style: UITableViewStyle.plain)
        self.view.addSubview(tableView)
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.separatorColor = UIColor.white
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadData() {
        
        HDManager.startLoading()
        CheckDetailModel.requestCheckData(self.keyWord!) { (checkArray, error) in
            if error == nil{

                self.dataArr.removeAllObjects()
                self.dataArr.addObjects(from: checkArray!)
                self.tableView.reloadData()

            }
                HDManager.stopLoading()
        }
    }
}


extension CheckDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "detail")
        if cell == nil{
            cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "detail")
        }
        
        let model = self.dataArr[(indexPath as NSIndexPath).row] as! List
        
        cell?.textLabel?.text = "●" + model.name
        cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
        cell?.detailTextLabel?.text = model.define
        cell?.detailTextLabel?.numberOfLines = 0
        cell?.detailTextLabel?.font = UIFont.init(name: "STHeitiSC-Light", size: 15)
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let comment = self.dataArr[(indexPath as NSIndexPath).row] as! List
        return 60 + comment.cellH//在模型中计算了高度
    }

}
