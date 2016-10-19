//
//  FeedsCell.swift
//  LoveDog
//
//  Created by wei on 16/9/7.
//  Copyright © 2016年 wei. All rights reserved.
//

import UIKit

protocol FeedsCellDelegate:class {
    
    func itemDidSelectedInRow(_ id:Int,row:Int)->Void
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
        
        headImage.frame = CGRect(x: 10, y: 10, width: 40, height: 40)
        headImage.layer.cornerRadius = headImage.frame.size.height / 2
        headImage.clipsToBounds = true
        self.contentView.addSubview(headImage)
        
        name.frame = CGRect(x: 60, y: 10, width: SCREEN_W - 115, height: 20)
        name.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(name)

        dateW.frame = CGRect(x: 60, y: 30, width: SCREEN_W - 115, height: 20)
        dateW.font = UIFont.init(name: "STHeitiSC-Light", size: 10)
        self.contentView.addSubview(dateW)
        
        detailL.frame = CGRect(x: 10, y: 60, width: SCREEN_W - 20, height: 0)
        detailL.font = UIFont.init(name: "STHeitiSC-Light", size: 15)
        detailL.numberOfLines = 0
        self.contentView.addSubview(detailL)
        
        photosView.frame = CGRect(x: 0, y: 60, width: SCREEN_W - 20, height: 0)
        self.contentView.addSubview(photosView)

    }
    
    func wipePhotos(){
        for photo in photos{
            photo.removeFromSuperview()
        }
        photos.removeAll()
    }
    
    func createPhotos(_ photoArr:[ImageUrl]){
        self.wipePhotos()
        let photoW = (SCREEN_W - 32) / 3
        for i in 0...photoArr.count - 1{
            let photo = UIImageView()
            photo.frame = CGRect(x: (8 + photoW) * CGFloat(i % 3), y: ((8 + photoW) * CGFloat(i / 3)), width: photoW, height: photoW)
            photo.sd_setImage(with: URL.init(string: photoArr[i].a360))
            photos.append(photo)
            photosView.addSubview(photo)
            
            //创建手势1
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction(_:)))
            photo.isUserInteractionEnabled = true
            //将手势加到图片上
            photo.addGestureRecognizer(tap)
            photo.tag = i + 1000
        }
    }
    
    func tapAction(_ tap:UITapGestureRecognizer){
        delegate?.itemDidSelectedInRow(((tap.view?.tag)! - 1000),row: self.row)
        
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
