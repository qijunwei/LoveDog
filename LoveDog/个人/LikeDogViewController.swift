//
//  LikeDogViewController.swift
//  LoveDog
//
//  Created by wei on 16/9/5.
//  Copyright © 2016年 wei. All rights reserved.
//

import UIKit
import FMDB
//收藏页
class LikeDogViewController: UIViewController {

    var dataArray = [DogModel]()
    var tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "收藏"
        //设置tableview
        tableView.frame = CGRectMake(0, 64, SCREEN_W - 16, SCREEN_H - 64 - 49)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = GRAYCOLOR2
        tableView.allowsSelection = false
        tableView.registerClass(LikeDogCell.self, forCellReuseIdentifier: "LikeDogCell")
        //强制在页脚加一个空视图，让多余的分割线消失
        tableView.tableFooterView = UIView.init(frame: CGRectZero)
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(tableView)
        
    }

    override func viewWillAppear(animated: Bool) {
        dataArray =  FMDBDataManager.defaultManger.selectAll()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension  LikeDogViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LikeDogCell", forIndexPath: indexPath) as! LikeDogCell
        var model : DogModel?
        model = dataArray[indexPath.row]
        cell.headImage.image = UIImage.init(named: (model?.id)!)
        cell.title.text = model?.name
        
        return cell
    }
    

}
