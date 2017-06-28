//
//  OtherPetsCell.swift
//  LoveDog
//
//  Created by wei on 16/9/6.
//  Copyright © 2016年 wei. All rights reserved.
//

import UIKit
import MJRefresh

class OtherPetsCell2: UICollectionViewCell,UITableViewDelegate,UITableViewDataSource {
    
    weak var delegate:OtherPetsViewControllerDelegate?

    var page: NSInteger = 1
    var lable = UILabel()
    var dataArr = NSMutableArray()
    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H-64), style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CuringCell.self, forCellReuseIdentifier: "CuringCell")
        self.contentView.addSubview(tableView)
        
        tableView.mj_header = QFRefeshHeader.init(refreshingBlock: {
            self.page = 1
            self.loadData()
        })
        
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page += 1
            self.loadData()
        })
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = GRAYCOLOR
        self.loadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData() {
        
        HDManager.startLoading()
        CuringModel.requestData(3,page: self.page){ (array, error) in
            if error == nil{
                
                if self.page == 1
                {
                    self.dataArr.removeAllObjects()
                }
                
                self.dataArr.addObjects(from: array!)
                self.tableView.reloadData()
                self.tableView.mj_footer.endRefreshing()
                self.tableView.mj_header.endRefreshing()
            }
            HDManager.stopLoading()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CuringCell", for: indexPath) as! CuringCell
        let model = self.dataArr[(indexPath as NSIndexPath).row] as! CuringModel
        cell.image1.sd_setImage(with: URL.init(string: model.thumb))
        cell.title.text = model.title
        cell.summary.text = model.summary
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cureVc = CureDetailViewController()
        let model = self.dataArr[(indexPath as NSIndexPath).row] as! CuringModel
        cureVc.uid = String(describing: model.id)
        
        cureVc.hidesBottomBarWhenPushed = true
        self.delegate?.pushToViewController(cureVc)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
