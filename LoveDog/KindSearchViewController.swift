//
//  KindSearchViewController.swift
//  LoveDog
//
//  Created by wei on 16/8/11.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class KindSearchViewController: DogKindViewController, UISearchBarDelegate, UISearchControllerDelegate {
    
    //搜索后的新tableview
    var newTableView : UITableView?
    var searchDataArr = [DogModel]() {
        didSet{
            self.newTableView?.reloadData()
        }
    }
    var searchController : UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view
        self.newTableView = nil
        self.view.backgroundColor = UIColor.whiteColor()
        newTableView = UITableView(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 49), style: .Plain)
        newTableView?.dataSource = self
        newTableView?.delegate = self
        self.view.addSubview(newTableView!)
        
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
        searchController?.delegate = self
        searchController?.searchBar.delegate = self
        searchController?.hidesNavigationBarDuringPresentation = true
        searchController?.dimsBackgroundDuringPresentation = false
        searchController?.searchBar.searchBarStyle = .Default
        searchController?.searchBar.sizeToFit()
        
        searchController?.searchBar.placeholder = "搜索"
        self.newTableView?.tableHeaderView = searchController?.searchBar
        
        self.newTableView!.registerNib(UINib.init(nibName: "SearchDogCell", bundle: nil), forCellReuseIdentifier: "SearchDogCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension  KindSearchViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController?.active == true{
            return searchDataArr.count
        }else{
            return dataArr.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentify = "SearchDogCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentify, forIndexPath: indexPath) as! SearchDogCell
        
        var model : DogModel?
        if searchController?.active == true{
            model = searchDataArr[indexPath.row]
        }else{
            model = dataArr[indexPath.row]
        }
        
        cell.headImage.image = UIImage.init(named: model!.image!)
        cell.dogName.text = model!.name
        cell.dogName.font = UIFont.boldSystemFontOfSize(15)
        cell.detail.text = model!.details
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //显示时的3D效果
            cell.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1);
            UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
                }, completion: nil)
        
        if searchController?.active == true{
            tableView.frame = CGRectMake(0, 20, SCREEN_W, SCREEN_H - 20 - 49)
        }else{
            tableView.frame = CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 49)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        searchController?.resignFirstResponder()
        //选中时，传值，并推出下一页面
        var model : DogModel?
        if searchController?.active == true{
            model = searchDataArr[indexPath.row]
        }else{
            model = dataArr[indexPath.row]
        }
        
        let detailVC = DogDetailViewController()
        detailVC.lable.text = model!.details
        detailVC.nameLabel.text = model!.name
        detailVC.imageView.sd_setImageWithURL(NSURL.init(string: model!.imgUrl!))
        
        detailVC.shareTitle = model?.name
        detailVC.shareUrl = model?.imgUrl
    
        self.navigationController?.pushViewController(detailVC, animated: true)
        searchController?.active = false
        detailVC.hidesBottomBarWhenPushed = true
    }
    
    func willPresentSearchController(searchController: UISearchController) {
        for view:UIView in (searchController.searchBar.subviews)
        {
            for subView:UIView in (view.subviews)
            {
                if ( subView is UIButton )
                {
                    let cancelBut = subView as! UIButton
                    cancelBut.setTitle("取消", forState: .Normal)
                }
            }
        }
    }
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {

    }
}

extension  KindSearchViewController: UISearchResultsUpdating{
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        searchDataArr.removeAll(keepCapacity: false)
        
        let searchText = searchController.searchBar.text!
        for model in dataArr{
            let name : NSString = model.name!
            if name.containsString(searchText) == true{
                searchDataArr.append(model)
            }
        }
    }
}
