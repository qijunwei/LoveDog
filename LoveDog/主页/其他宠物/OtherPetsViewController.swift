//
//  OtherPetsViewController.swift
//  LoveDog
//
//  Created by wei on 16/9/3.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

protocol OtherPetsViewControllerDelegate:class {
    
    func pushToViewController(vc:UIViewController)->Void
}

//带导航上的条条
class OtherPetsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,NaviTitleViewDelegate,OtherPetsViewControllerDelegate {

    var titleView:NaviTitleView!
    var collectionView:UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.createCollectionView()
        self.createTitleView()
        titleView.setIndex(0)
    }

    //创建滑动的标签
    func createTitleView(){
        titleView = NaviTitleView.init(frame: CGRectMake(80, 20, SCREEN_W - 160, 44), titleArray: ["推荐","猫猫","小宠","其他"])
        titleView.delegate = self
        self.navigationItem.titleView = titleView
    }
    
    func titleDidSelectedAtIndex(index: NSInteger) {
        collectionView.contentOffset = CGPointMake(CGFloat(index) * SCREEN_W, 0)
    }
    
    func createCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        collectionView = UICollectionView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerClass(OtherPetsCell.self, forCellWithReuseIdentifier: "OtherPetsCell")
        collectionView.registerClass(OtherPetsCell1.self, forCellWithReuseIdentifier: "OtherPetsCell1")
        collectionView.registerClass(OtherPetsCell2.self, forCellWithReuseIdentifier: "OtherPetsCell2")
        collectionView.registerClass(OtherPetsCell3.self, forCellWithReuseIdentifier: "OtherPetsCell3")
        collectionView.pagingEnabled = true
        self.view.addSubview(collectionView)
        self.automaticallyAdjustsScrollViewInsets = false
        collectionView.backgroundColor = GRAYCOLOR
//        collectionView.contentOffset = CGPointMake(SCREEN_W, 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.item == 0{
            let cellId = "OtherPetsCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! OtherPetsCell
            cell.delegate = self
            return cell
        }else if indexPath.item == 1{
            let cellId = "OtherPetsCell1"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! OtherPetsCell1
            cell.delegate = self

            return cell
        }else if indexPath.item == 2{
            let cellId = "OtherPetsCell2"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! OtherPetsCell2
            cell.delegate = self

            return cell
        }else{
            let cellId = "OtherPetsCell3"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! OtherPetsCell3
            cell.delegate = self

            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(SCREEN_W, SCREEN_H - 64)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        return 0
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let index = scrollView.contentOffset.x / SCREEN_W
        
        titleView.setIndex(NSInteger(index))
    }
    
    
    //MARK:- CommunityDelegate协议方法
    
    func pushToViewController(vc: UIViewController) {
        
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
