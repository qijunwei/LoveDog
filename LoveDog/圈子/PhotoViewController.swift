//
//  PhotoViewController.swift
//  LoveDog
//
//  Created by wei on 16/9/10.
//  Copyright © 2016年 wei. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController,UIScrollViewDelegate {
    
    var photoArray = [ImageUrl]()
    var id = 0
    
    var scrollView = UIScrollView()
    var pageCtl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        
        scrollView.frame = UIScreen.mainScreen().bounds
        self.view.addSubview(scrollView)
        
        for i in 0...photoArray.count - 1{
            
            let photoView = UIImageView()
            photoView.frame = CGRectMake(CGFloat(i)*SCREEN_W, 20, SCREEN_W, SCREEN_H - 20)
            photoView.contentMode = .ScaleAspectFit
            photoView.sd_setImageWithURL(NSURL.init(string: photoArray[i].a360))
            photoView.tag = 200 + i
            
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(PhotoViewController.tapAction))
            photoView.userInteractionEnabled = true
            photoView.addGestureRecognizer(tap)
            
            scrollView.addSubview(photoView)
        }
        
        //禁掉提示条
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        //设置滚动视图的滚动视图
        scrollView.contentSize = CGSizeMake(CGFloat(scrollView.subviews.count) * SCREEN_W, SCREEN_H)
//        设置偏移
        scrollView.contentOffset = CGPointMake(SCREEN_W * CGFloat(id), 0)
        //禁止回弹
        scrollView.bounces = false
        //开启滚动视图的翻页功能
        scrollView.pagingEnabled = true
        //代理
        scrollView.delegate = self
        
        
//        页码指示器
        //配置页码指示码
        pageCtl.frame = CGRectMake(0, scrollView.subviews[0].frame.origin.y + scrollView.subviews[0].frame.size.height - 30, SCREEN_W, 30)
        //配置指示器的总页数
        pageCtl.numberOfPages = scrollView.subviews.count
        //配置非当前页的颜色
        pageCtl.pageIndicatorTintColor = GRAYCOLOR
        //配置当前页的颜色
        pageCtl.currentPageIndicatorTintColor = UIColor.redColor()
        //虽然这个是一个事件驱动型控件，可以加事件来做相应的操作，
        //但一般的情况下，我们都不会加事件，只会让他被动的显示当前页即可
        pageCtl.enabled = false
        pageCtl.currentPage = id
        self.view.addSubview(pageCtl)
        
    }
    
    func tapAction(){
        self.dismissViewControllerAnimated(false, completion: nil)
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let index = scrollView.contentOffset.x / SCREEN_W
        pageCtl.currentPage = NSInteger(index)
    }
    
}
