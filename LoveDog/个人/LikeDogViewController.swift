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
        self.view.backgroundColor = UIColor.white
        self.title = "收藏"
        //设置tableview
        tableView.frame = CGRect(x: 0, y: 64, width: SCREEN_W - 16, height: SCREEN_H - 64 - 49)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = GRAYCOLOR2
        //tableview不允许被被选中
        tableView.allowsSelection = false
        tableView.register(LikeDogCell.self, forCellReuseIdentifier: "LikeDogCell")
        //强制在页脚加一个空视图，让多余的分割线消失
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(tableView)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        dataArray =  FMDBDataManager.defaultManger.selectAll()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension  LikeDogViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikeDogCell", for: indexPath) as! LikeDogCell
        var model : DogModel?
        model = dataArray[(indexPath as NSIndexPath).row]
        cell.headImage.image = UIImage.init(named: (model?.id)!)
        cell.title.text = model?.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        //返回编辑操作的风格为删除操作
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //删除的操作要写在这个方法里
        //如果使用的默认的删除风格，那么在实现了这个方法时，在非编辑状态下，左划会出现一个单行删除的操作
        
        //要删除就要在数据中操作
        let model = dataArray[(indexPath as NSIndexPath).row]
        FMDBDataManager.defaultManger.deleteSql(model, uid: model.id!)
        dataArray = FMDBDataManager.defaultManger.selectAll()
        //还是要刷新
        tableView.deleteRows(at: [indexPath], with: .right)
        
    }
    //tableview自带删除改成汉字
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除收藏"
    }

}
