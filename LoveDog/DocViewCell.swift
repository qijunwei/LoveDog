//
//  DocViewCell.swift
//  LoveDog
//
//  Created by wei on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class DocViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    var dataArr = [DoctorModel]()
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, data: [DoctorModel]) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        dataArr = data
        self.createCollentionView()
        
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
    
    func createCollentionView(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        layout.itemSize = CGSizeMake(100, 180)
        layout.minimumLineSpacing = (SCREEN_W - 400) / 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView = UICollectionView.init(frame: CGRectMake((SCREEN_W - 400) / 5, 0, SCREEN_W, 180), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerClass(DocCollectionViewCell.self, forCellWithReuseIdentifier: "DocCollectionViewCell")
        collectionView.pagingEnabled = true
        self.contentView.addSubview(collectionView)
        collectionView.backgroundColor = GRAYCOLOR
//        collectionView.contentOffset = CGPointMake(SCREEN_W + SCREEN_W, 0)
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DocCollectionViewCell", forIndexPath: indexPath) as! DocCollectionViewCell
        let model = self.dataArr[indexPath.item] 
        
        cell.nameLabel.text = model.name
        cell.imageView.sd_setImageWithURL(NSURL.init(string: model.avatar))
        cell.jobLabel.text = model.job
        cell.backgroundColor = UIColor.whiteColor()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        return 2
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2
    }

}
