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
        self.view.backgroundColor = UIColor.white
        newTableView = UITableView(frame: CGRect(x: 0, y: 64, width: SCREEN_W, height: SCREEN_H - 64 - 49), style: .plain)
        newTableView?.dataSource = self
        newTableView?.delegate = self
        self.view.addSubview(newTableView!)
        
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
        searchController?.delegate = self
        searchController?.searchBar.delegate = self
        searchController?.hidesNavigationBarDuringPresentation = true
        searchController?.dimsBackgroundDuringPresentation = false
        searchController?.searchBar.searchBarStyle = .default
        searchController?.searchBar.sizeToFit()
        
        searchController?.searchBar.placeholder = "搜索"
        self.newTableView?.tableHeaderView = searchController?.searchBar
        
        self.newTableView!.register(UINib.init(nibName: "SearchDogCell", bundle: nil), forCellReuseIdentifier: "SearchDogCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension  KindSearchViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController?.isActive == true{
            return searchDataArr.count
        }else{
            return dataArr.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentify = "SearchDogCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentify, for: indexPath) as! SearchDogCell
        
        var model : DogModel?
        if searchController?.isActive == true{
            model = searchDataArr[(indexPath as NSIndexPath).row]
        }else{
            model = dataArr[(indexPath as NSIndexPath).row]
        }
        
        cell.headImage.image = UIImage.init(named: model!.image!)
        cell.dogName.text = model!.name
        cell.dogName.font = UIFont.boldSystemFont(ofSize: 15)
        cell.detail.text = model!.details
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
        //显示时的3D效果
            cell.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1);
            UIView.animate(withDuration: 0.4, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
                }, completion: nil)
        
        if searchController?.isActive == true{
            tableView.frame = CGRect(x: 0, y: 20, width: SCREEN_W, height: SCREEN_H - 20 - 49)
        }else{
            tableView.frame = CGRect(x: 0, y: 64, width: SCREEN_W, height: SCREEN_H - 64 - 49)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchController?.resignFirstResponder()
        //选中时，传值，并推出下一页面
        var model : DogModel?
        if searchController?.isActive == true{
            model = searchDataArr[(indexPath as NSIndexPath).row]
        }else{
            model = dataArr[(indexPath as NSIndexPath).row]
        }
        
        let detailVC = DogDetailViewController()
        detailVC.model = model!
        detailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailVC, animated: true)
        searchController?.isActive = false
        
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        for view:UIView in (searchController.searchBar.subviews)
        {
            for subView:UIView in (view.subviews)
            {
                if ( subView is UIButton )
                {
                    let cancelBut = subView as! UIButton
                    cancelBut.setTitle("取消", for: UIControlState())
                }
            }
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

    }
}

extension  KindSearchViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        searchDataArr.removeAll(keepingCapacity: false)
        
        let searchText = searchController.searchBar.text!
        for model in dataArr{
            let name : NSString = model.name! as NSString
            if name.contains(searchText) == true{
                searchDataArr.append(model)
            }
        }
    }
}
