//
//  NaviTitleView.swift
//  LoveDog
//
//  Created by wei on 16/9/6.
//  Copyright © 2016年 wei. All rights reserved.
//

import UIKit

protocol NaviTitleViewDelegate :class  {
    
    func titleDidSelectedAtIndex(_ index:NSInteger)->Void
}

class NaviTitleView: UIView {
    
    let leftSpace:CGFloat = 80
    let topSpace :CGFloat = 20
    let btnH:CGFloat = 23
    var btnW :CGFloat = 0
    var sliderView:UIView!
    var seletedIndex:NSInteger = 0 //记录上一次选中
    weak var delegate:NaviTitleViewDelegate?
    
    init(frame: CGRect,titleArray:[String]) {
        
        super.init(frame: frame)
        self.createSubviews(titleArray)
    }
    //创建子视图
    func createSubviews(_ titleArray:[String])
    {
        btnW = (SCREEN_W - 2 * leftSpace) / CGFloat(titleArray.count)
        var i = 0
        for title in titleArray
        {
            let btn = UIButton.init(frame: CGRect(x: btnW * CGFloat(i), y: topSpace, width: btnW, height: btnH))
            btn.setTitle(title, for: UIControlState())
            btn.setTitleColor( TEXTGRYCOLOR, for: UIControlState())
            btn.setTitleColor( TEXTGRYCOLOR, for: UIControlState.highlighted)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            btn.tag = 100 + i
            self.addSubview(btn)
            btn.addTarget(self, action: #selector(self.titleDidClicked(_:)), for: UIControlEvents.touchUpInside)
            i += 1
        }
        
        sliderView = UIView.init(frame: CGRect(x: 0, y: self.frame.size.height - 2, width: btnW, height: 2))
        sliderView.backgroundColor = UIColor.darkGray
        self.addSubview(sliderView)
    }
    func titleDidClicked(_ button:UIButton){
        
        self.setIndex(button.tag - 100)
        self.delegate?.titleDidSelectedAtIndex(button.tag - 100)
    }
    
    func setIndex(_ index:NSInteger){
        
        //取出上一次选中的按钮，更改颜色
        let preBtn = self.viewWithTag(100 + self.seletedIndex) as! UIButton
        
        preBtn.setTitleColor(TEXTGRYCOLOR, for: UIControlState())
        preBtn.setTitleColor(TEXTGRYCOLOR, for: UIControlState.highlighted)
        
        //取出当前选中的按钮
        let button = self.viewWithTag(100 + index) as! UIButton
        //改变现状选中的按钮的颜色
        
        button.setTitleColor(UIColor.darkGray, for: UIControlState())
        button.setTitleColor(UIColor.darkGray, for: UIControlState.highlighted)
        
        seletedIndex = index
        
        UIView.animate(withDuration: 0.25, animations: {
            //更改滑块的位置
            self.sliderView.mj_x = CGFloat(self.seletedIndex) * self.btnW
        }) 
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
