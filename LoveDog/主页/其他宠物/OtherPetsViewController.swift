//
//  OtherPetsViewController.swift
//  LoveDog
//
//  Created by wei on 16/9/3.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

protocol OtherPetsViewControllerDelegate:class {
    
    func pushToViewController(_ vc:UIViewController)->Void
}

//带导航上的条条
class OtherPetsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,NaviTitleViewDelegate,OtherPetsViewControllerDelegate {

    var titleView:NaviTitleView!
    var collectionView:UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.createCollectionView()
        self.createTitleView()
        titleView.setIndex(0)
    }

    //创建滑动的标签
    func createTitleView(){
        titleView = NaviTitleView.init(frame: CGRect(x: 80, y: 20, width: SCREEN_W - 160, height: 44), titleArray: ["推荐","猫猫","小宠","其他"])
        titleView.delegate = self
        self.navigationItem.titleView = titleView
    }
    
    func titleDidSelectedAtIndex(_ index: NSInteger) {
        collectionView.contentOffset = CGPoint(x: CGFloat(index) * SCREEN_W, y: 0)
    }
    
    func createCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 64, width: SCREEN_W, height: SCREEN_H - 64), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(OtherPetsCell.self, forCellWithReuseIdentifier: "OtherPetsCell")
        collectionView.register(OtherPetsCell1.self, forCellWithReuseIdentifier: "OtherPetsCell1")
        collectionView.register(OtherPetsCell2.self, forCellWithReuseIdentifier: "OtherPetsCell2")
        collectionView.register(OtherPetsCell3.self, forCellWithReuseIdentifier: "OtherPetsCell3")
        collectionView.isPagingEnabled = true
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath as NSIndexPath).item == 0{
            let cellId = "OtherPetsCell"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! OtherPetsCell
            cell.delegate = self
            return cell
        }else if (indexPath as NSIndexPath).item == 1{
            let cellId = "OtherPetsCell1"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! OtherPetsCell1
            cell.delegate = self

            return cell
        }else if (indexPath as NSIndexPath).item == 2{
            let cellId = "OtherPetsCell2"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! OtherPetsCell2
            cell.delegate = self

            return cell
        }else{
            let cellId = "OtherPetsCell3"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! OtherPetsCell3
            cell.delegate = self

            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: SCREEN_W, height: SCREEN_H - 64)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let index = scrollView.contentOffset.x / SCREEN_W
        
        titleView.setIndex(NSInteger(index))
    }
    
    
    //MARK:- CommunityDelegate协议方法
    
    func pushToViewController(_ vc: UIViewController) {
        
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
