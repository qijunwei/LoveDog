//
//  HospViewCell.swift
//  LoveDog
//
//  Created by wei on 16/8/14.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class HospViewCell: UITableViewCell {
    
    var headImage = UIImageView()
    var title = UILabel()
    var address = UILabel()
    var tel = UILabel()
    //查看全部
    var seemore = UILabel()
    
    //距离
    var disL = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        headImage.frame = CGRectMake(16, 10, 100, 70)
        self.contentView.addSubview(headImage)
        
        title.frame = CGRectMake(140, 10, SCREEN_W - 220, 20)
        title.font = UIFont.systemFontOfSize(17)
        self.contentView.addSubview(title)
        
        disL.frame = CGRectMake(SCREEN_W - 60, 10, 60, 20)
        disL.font = UIFont.init(name: "STHeitiSC-Light", size: 12)
        self.contentView.addSubview(disL)
        
        tel.frame = CGRectMake(140, 30, SCREEN_W - 145, 30)
        tel.font = UIFont.init(name: "STHeitiSC-Light", size: 15)
        self.contentView.addSubview(tel)
        
        address.frame = CGRectMake(140, 50, SCREEN_W - 145, 50)
        address.font = UIFont.init(name: "STHeitiSC-Light", size: 15)
        address.numberOfLines = 2
        self.contentView.addSubview(address)
        
        //“查看全部”cell单独列出来，
        seemore.frame = CGRectMake((SCREEN_W - 100) / 2, 10, 100, 20)
        seemore.center.x = SCREEN_W / 2
        seemore.textAlignment = .Center
        seemore.font = UIFont.systemFontOfSize(15)
        seemore.textColor = UIColor.grayColor()
        self.contentView.addSubview(seemore)
     
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


//如果想要内嵌一个tableview，则用到以下内容

//class HospViewCell: UITableViewCell ,UITableViewDelegate,UITableViewDataSource{
//    
//    var tableView:UITableView!
//    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        tableView = UITableView.init(frame: CGRectMake(0, 0, SCREEN_W, 300), style: UITableViewStyle.Plain)
//        self.contentView.addSubview(tableView)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.rowHeight = 50
//        tableView.scrollEnabled = false
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//    
//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        // Configure the view for the selected state
//    }
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 6
//    }
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        var cell = tableView.dequeueReusableCellWithIdentifier("qq1")
//        if cell == nil{
//            cell = UITableViewCell.init(style: .Default, reuseIdentifier: "qq1")
//
//        }
//        
//        cell?.textLabel?.text = "养护手册"
//        cell?.detailTextLabel?.text = "新手养宠攻略"
//        return cell!
//    }
//    
//}
