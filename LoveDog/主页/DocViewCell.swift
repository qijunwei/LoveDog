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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func createCollentionView(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.itemSize = CGSize(width: 90, height: 170)
        layout.minimumLineSpacing = (SCREEN_W - 400) / 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView = UICollectionView.init(frame: CGRect(x: (SCREEN_W - 400) / 5, y: 0, width: SCREEN_W, height: 180), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(DocCollectionViewCell.self, forCellWithReuseIdentifier: "DocCollectionViewCell")
        collectionView.isPagingEnabled = true
        self.contentView.addSubview(collectionView)
        collectionView.backgroundColor = GRAYCOLOR
//        collectionView.contentOffset = CGPointMake(SCREEN_W + SCREEN_W, 0)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DocCollectionViewCell", for: indexPath) as! DocCollectionViewCell
        let model = self.dataArr[(indexPath as NSIndexPath).item] 
        
        cell.nameLabel.text = model.name
        cell.imageView.sd_setImage(with: URL.init(string: model.avatar))
        cell.jobLabel.text = model.job
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

}
