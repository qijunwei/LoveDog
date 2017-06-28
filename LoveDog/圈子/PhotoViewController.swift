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
        
        self.view.backgroundColor = UIColor.black
        
        scrollView.frame = UIScreen.main.bounds
        self.view.addSubview(scrollView)
        
        for i in 0...photoArray.count - 1{
            
            let photoView = UIImageView()
            photoView.frame = CGRect(x: CGFloat(i)*SCREEN_W, y: 20, width: SCREEN_W, height: SCREEN_H - 20)
            photoView.contentMode = .scaleAspectFit
            photoView.sd_setImage(with: URL.init(string: photoArray[i].a360))
            photoView.tag = 200 + i
            
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(PhotoViewController.tapAction))
            photoView.isUserInteractionEnabled = true
            photoView.addGestureRecognizer(tap)
            
            scrollView.addSubview(photoView)
        }
        
        //禁掉提示条
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        //设置滚动视图的滚动视图
        scrollView.contentSize = CGSize(width: CGFloat(scrollView.subviews.count) * SCREEN_W, height: SCREEN_H)
//        设置偏移
        scrollView.contentOffset = CGPoint(x: SCREEN_W * CGFloat(id), y: 0)
        //禁止回弹
        scrollView.bounces = false
        //开启滚动视图的翻页功能
        scrollView.isPagingEnabled = true
        //代理
        scrollView.delegate = self
        
        
//        页码指示器
        //配置页码指示码
        pageCtl.frame = CGRect(x: 0, y: scrollView.subviews[0].frame.origin.y + scrollView.subviews[0].frame.size.height - 30, width: SCREEN_W, height: 30)
        //配置指示器的总页数
        pageCtl.numberOfPages = scrollView.subviews.count
        //配置非当前页的颜色
        pageCtl.pageIndicatorTintColor = GRAYCOLOR
        //配置当前页的颜色
        pageCtl.currentPageIndicatorTintColor = UIColor.red
        //虽然这个是一个事件驱动型控件，可以加事件来做相应的操作，
        //但一般的情况下，我们都不会加事件，只会让他被动的显示当前页即可
        pageCtl.isEnabled = false
        pageCtl.currentPage = id
        self.view.addSubview(pageCtl)
        
    }
    
    func tapAction(){
        self.dismiss(animated: false, completion: nil)
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let index = scrollView.contentOffset.x / SCREEN_W
        pageCtl.currentPage = NSInteger(index)
    }
    
}
