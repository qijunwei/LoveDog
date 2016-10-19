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
        
        headImage.frame = CGRect(x: 16, y: 10, width: 100, height: 70)
        self.contentView.addSubview(headImage)
        
        title.frame = CGRect(x: 140, y: 10, width: SCREEN_W - 220, height: 20)
        title.font = UIFont.systemFont(ofSize: 17)
        self.contentView.addSubview(title)
        
        disL.frame = CGRect(x: SCREEN_W - 60, y: 10, width: 60, height: 20)
        disL.font = UIFont.init(name: "STHeitiSC-Light", size: 12)
        self.contentView.addSubview(disL)
        
        tel.frame = CGRect(x: 140, y: 30, width: SCREEN_W - 145, height: 30)
        tel.font = UIFont.init(name: "STHeitiSC-Light", size: 15)
        self.contentView.addSubview(tel)
        
        address.frame = CGRect(x: 140, y: 50, width: SCREEN_W - 145, height: 50)
        address.font = UIFont.init(name: "STHeitiSC-Light", size: 15)
        address.numberOfLines = 2
        self.contentView.addSubview(address)
        
        //“查看全部”cell单独列出来，
        seemore.frame = CGRect(x: (SCREEN_W - 100) / 2, y: 10, width: 100, height: 20)
        seemore.center.x = SCREEN_W / 2
        seemore.textAlignment = .center
        seemore.font = UIFont.systemFont(ofSize: 15)
        seemore.textColor = UIColor.gray
        self.contentView.addSubview(seemore)
     
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
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
