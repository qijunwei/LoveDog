//
//  MainDetailViewController.swift
//  LoveDog
//
//  Created by wei on 16/8/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MainDetailViewController: UIViewController {
    
    var id: String!
    var lable = UILabel()
    var dataArr = NSMutableArray()
    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 64, width: SCREEN_W, height: SCREEN_H-64), style: UITableViewStyle.plain)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainDetailCell.self, forCellReuseIdentifier: "MainDetailCell")
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_W , height: 120))
        self.lable.frame = CGRect(x: 10, y: 0, width: SCREEN_W - 30, height: 120)
        view.addSubview(self.lable)
        
        tableView.tableHeaderView = view
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
        self.loadData()
    }
    
    func loadData() {
        
        HDManager.startLoading()
        MainModel.requestData1(self.id){ (content, error) in
            if error == nil
            {
                self.lable.text = content
                self.lable.font = UIFont.init(name: "STHeitiSC-Light", size: 15)
                self.lable.numberOfLines = 5
                self.tableView.reloadData()
            }
            HDManager.stopLoading()
        }
        MainModel.requestData2(self.id){ (array, error) in
            if error == nil{
                self.dataArr.removeAllObjects()
                self.dataArr.addObjects(from: array!)
                self.tableView.reloadData()
            }
            HDManager.stopLoading()
        }
    }
}

extension MainDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainDetailCell", for: indexPath) as! MainDetailCell
        let model = self.dataArr[(indexPath as NSIndexPath).row] as! MainDetailModel
        cell.image1.sd_setImage(with: URL.init(string: model.thumb))
        cell.title.text = model.title
        cell.good.text = String(describing: model.up) + "人觉得有用"
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.dataArr[(indexPath as NSIndexPath).row] as! MainDetailModel
        let mainVc = MainWebviewViewController()
        mainVc.uid = String(describing: model.id)
        mainVc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(mainVc, animated: true)
    }
}

