//
//  SearchDogViewController.swift
//  LoveDog
//
//  Created by qianfeng on 16/7/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class DogKindViewController: UIViewController {

    var tableView = UITableView()//展示所有狗
    var dataArr = [DogModel]()//狗的数据源
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        //解析本地json文件
        let path = NSBundle.mainBundle().pathForResource("dog.txt", ofType: nil)!
        let data = NSData.init(contentsOfFile: path)!
        let dogArr = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [NSDictionary]
        for dogDic in dogArr! {
            let model = DogModel()
            model.name = dogDic["name"] as? String
            model.id = dogDic["id"] as? String
            model.longName = dogDic["longName"] as? String
            model.englishName = dogDic["englishName"] as? String
            model.type = dogDic["type"] as? String
            model.details = dogDic["details"] as? String
            model.image = (dogDic["id"] as? String)!
            model.imgUrl = dogDic["imgUrl"] as? String
            dataArr.append(model)
        }
        //设置tableview
        tableView.frame = CGRectMake(0, 64, SCREEN_W - 16, SCREEN_H - 64 - 49)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = GRAYCOLOR2
        self.tableView.registerNib(UINib.init(nibName: "SearchDogCell", bundle: nil), forCellReuseIdentifier: "SearchDogCell")
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(tableView)
    }
}

extension DogKindViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cellIdentify = "SearchDogCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentify, forIndexPath: indexPath) as! SearchDogCell
        
        let model = dataArr[indexPath.row]

        cell.headImage.image = UIImage.init(named: model.image!)
        cell.dogName.text = model.name
        cell.dogName.font = UIFont.boldSystemFontOfSize(15)
        cell.detail.text = model.details
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //选中时，传值，并推出下一页面
        let model = dataArr[indexPath.row]
        let detailVC = DogDetailViewController()
        detailVC.lable.text = model.details
        detailVC.nameLabel.text = model.name
        detailVC.imageView.sd_setImageWithURL(NSURL.init(string: model.imgUrl!))
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
