//
//  SearchDogViewController.swift
//  LoveDog
//
//  Created by qianfeng on 16/7/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import SDWebImage

class DogKindViewController: UIViewController {

    var tableView = UITableView()//展示所有狗
    var dataArr = [DogModel]()//狗的数据源
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //解析本地json文件
        let path = Bundle.main.path(forResource: "dog.txt", ofType: nil)!
        let data = try! Foundation.Data.init(contentsOf: URL(fileURLWithPath: path))
        let dogArr = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [NSDictionary]
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
        tableView.frame = CGRect(x: 0, y: 64, width: SCREEN_W - 16, height: SCREEN_H - 64 - 49)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = GRAYCOLOR2
        self.tableView.register(UINib.init(nibName: "SearchDogCell", bundle: nil), forCellReuseIdentifier: "SearchDogCell")
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(tableView)
    }
}

extension DogKindViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentify = "SearchDogCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentify, for: indexPath) as! SearchDogCell
        
        let model = dataArr[(indexPath as NSIndexPath).row]

        cell.headImage.image = UIImage.init(named: model.image!)
        cell.dogName.text = model.name
        cell.dogName.font = UIFont.boldSystemFont(ofSize: 15)
        cell.detail.text = model.details
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //选中时，传值，并推出下一页面
        let model = dataArr[(indexPath as NSIndexPath).row]
        let detailVC = DogDetailViewController()
        detailVC.lable.text = model.details
        detailVC.nameLabel.text = model.name
        detailVC.imageView.sd_setImage(with: URL.init(string: model.imgUrl!))
        detailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
