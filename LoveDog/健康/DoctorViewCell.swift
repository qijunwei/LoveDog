//
//  HospViewCell.swift
//  LoveDog
//
//  Created by wei on 16/8/14.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class DoctorViewCell: UITableViewCell {
    
    var headImage = UIImageView()
    var job = UILabel()
    var name = UILabel()
    var intro = UILabel()
    var hos = UILabel()
    
    //距离
    var disL = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        headImage.frame = CGRect(x: 16, y: 10, width: 70, height: 70)
        self.contentView.addSubview(headImage)
        
        job.frame = CGRect(x: 20, y: 85, width: 100, height: 20)
        job.font = UIFont.init(name: "STHeitiSC-Light", size: 15)
        self.contentView.addSubview(job)
        
        name.frame = CGRect(x: 110, y: 10, width: SCREEN_W - 195, height: 20)
        name.font = UIFont.init(name: "STHeitiSC-Light", size: 17)
        self.contentView.addSubview(name)
        
        disL.frame = CGRect(x: SCREEN_W - 60, y: 10, width: 60, height: 20)
        disL.font = UIFont.init(name: "STHeitiSC-Light", size: 12)
        self.contentView.addSubview(disL)
        
        hos.frame = CGRect(x: 110, y: 35, width: SCREEN_W - 115, height: 20)
        self.contentView.addSubview(hos)
        
        intro.frame = CGRect(x: 110, y: 60, width: SCREEN_W - 115, height: 40)
        intro.font = UIFont.init(name: "STHeitiSC-Light", size: 13)
        intro.numberOfLines = 2
        self.contentView.addSubview(intro)
        
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
