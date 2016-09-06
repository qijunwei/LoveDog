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
        //tableview不允许被被选中
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
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        //返回编辑操作的风格为删除操作
        return .Delete
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //删除的操作要写在这个方法里
        //如果使用的默认的删除风格，那么在实现了这个方法时，在非编辑状态下，左划会出现一个单行删除的操作
        
        //要删除就要在数据中操作
        let model = dataArray[indexPath.row]
        FMDBDataManager.defaultManger.deleteSql(model, uid: model.id!)
        dataArray = FMDBDataManager.defaultManger.selectAll()
        //还是要刷新
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Right)
        
    }
    //tableview自带删除改成汉字
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除收藏"
    }

}
