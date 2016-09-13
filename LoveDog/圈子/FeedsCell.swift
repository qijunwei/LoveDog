//
//  FeedsCell.swift
//  LoveDog
//
//  Created by wei on 16/9/7.
//  Copyright © 2016年 wei. All rights reserved.
//

import UIKit

protocol FeedsCellDelegate:class {
    
    func itemDidSelectedInRow(id:Int,row:Int)->Void
}

class FeedsCell: UITableViewCell {

    var headImage = UIImageView()
    var name = UILabel()
    var detailL = UILabel()
    var dateW = UILabel()
    var sharePhotos = UIView()
    
    var photos = [UIImageView]()
    var photosView = UIView()
    
    //点击哪张照片
    weak var delegate:FeedsCellDelegate?
    var row = 0
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        headImage.frame = CGRectMake(10, 10, 40, 40)
        headImage.layer.cornerRadius = headImage.frame.size.height / 2
        headImage.clipsToBounds = true
        self.contentView.addSubview(headImage)
        
        name.frame = CGRectMake(60, 10, SCREEN_W - 115, 20)
        name.font = UIFont.systemFontOfSize(16)
        self.contentView.addSubview(name)

        dateW.frame = CGRectMake(60, 30, SCREEN_W - 115, 20)
        dateW.font = UIFont.init(name: "STHeitiSC-Light", size: 10)
        self.contentView.addSubview(dateW)
        
        detailL.frame = CGRectMake(10, 60, SCREEN_W - 20, 0)
        detailL.font = UIFont.init(name: "STHeitiSC-Light", size: 15)
        detailL.numberOfLines = 0
        self.contentView.addSubview(detailL)
        
        photosView.frame = CGRectMake(0, 60, SCREEN_W - 20, 0)
        self.contentView.addSubview(photosView)

    }
    
    func wipePhotos(){
        for photo in photos{
            photo.removeFromSuperview()
        }
        photos.removeAll()
    }
    
    func createPhotos(photoArr:[ImageUrl]){
        self.wipePhotos()
        let photoW = (SCREEN_W - 32) / 3
        for i in 0...photoArr.count - 1{
            let photo = UIImageView()
            photo.frame = CGRectMake((8 + photoW) * CGFloat(i % 3), ((8 + photoW) * CGFloat(i / 3)), photoW, photoW)
            photo.sd_setImageWithURL(NSURL.init(string: photoArr[i].a360))
            photos.append(photo)
            photosView.addSubview(photo)
            
            //创建手势1
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction(_:)))
            photo.userInteractionEnabled = true
            //将手势加到图片上
            photo.addGestureRecognizer(tap)
            photo.tag = i + 1000
        }
    }
    
    func tapAction(tap:UITapGestureRecognizer){
        delegate?.itemDidSelectedInRow(((tap.view?.tag)! - 1000),row: self.row)
        
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
