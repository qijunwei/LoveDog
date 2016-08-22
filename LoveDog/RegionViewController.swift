//
//  RegionViewController.swift
//  LoveDog
//
//  Created by wei on 16/8/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

protocol RegionViewControllerDelegate:class {
    func sendText(city:String)->Void
}

class RegionViewController: UIViewController {

    var tableView: UITableView!
    var dataArr: NSMutableArray!
    var headview: UIButton!
    var headertitle = "北京"
    
    weak var delegate:RegionViewControllerDelegate?
    //加定位，加城市列表，返回前面的城市
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        self.createTableView()

        dataArr = [["北京","上海","广州","南京","杭州"],["阿拉善","安庆","鞍山","安阳","澳门"],["北京","保定","包头","巴中","蚌埠","本溪","滨州","亳州"],["重庆","成都","长沙","长春","沧州","常德","长治","常州","潮州","承德","郴州","赤峰","池州","崇左","楚雄","滁州","朝阳"],["大连","东莞","大理","大庆","大同","德阳","德州","东营"],["鄂尔多斯","恩施","鄂州"],["福州","防城港","佛山","抚顺","抚州","阜新","阜阳"],["广州","桂林","贵阳","甘南","赣州","甘孜","广安","广元","贵港","果洛"],["杭州","哈尔滨","合肥","海口","呼和浩特","海北","海东","海南","海西","邯郸","汉中","鹤壁","河池","鹤岗","黑河","衡水","衡阳","河源","贺州","红河","淮安","淮北","怀化","淮南","黄冈","黄南","黄山","黄石","惠州","葫芦岛","呼伦贝尔","湖州","菏泽"],["济南","佳木斯","吉安","江门","焦作","嘉兴","嘉峪关","揭阳","吉林","金昌","晋城","景德镇","荆门","荆州","金华","济宁","晋中","锦州","九江","酒泉"],["昆明","开封"],["兰州","拉萨","来宾","莱芜","廊坊","乐山","凉山","连云港","聊城","辽阳","辽源","丽江","临沧","临汾","临夏","临沂","林芝","丽水","六安","六盘水","柳州","漯河","洛阳"],["马鞍山","茂名","眉山","梅州","绵阳","牡丹江"],["南京","南昌","南宁","宁波","南充","南平","南通","南阳","那曲","内江","宁德","怒江"],["盘锦","攀枝花","平顶山","平凉","萍乡","莆田","濮阳"],["青岛","黔东南","黔南","黔西南","庆阳","清远","秦皇岛","钦州","齐齐哈尔","泉州","曲靖","衢州"],["日喀则","日照"],["上海","深圳","苏州","沈阳","石家庄","三门峡","三明","三亚","商洛","商丘","上饶","山南","汕头","汕尾","韶关","绍兴","邵阳","十堰","朔州","四平","绥化","遂宁","随州","宿迁","宿州"],["天津","太原","泰安","泰州","台州","唐山","天水","铁岭","铜川","通化","通辽","铜陵","铜仁","台湾"],["武汉","乌鲁木齐","无锡","威海","潍坊","文山","温州","乌海","芜湖","乌兰察布","武威","梧州"],["厦门","西安","西宁","襄樊","湘潭","湘西","咸宁","咸阳","孝感","邢台","新乡","信阳","新余","忻州","西双版纳","宣城","许昌","徐州","香港","锡林郭勒","兴安"],["银川","雅安","延安","延边","盐城","阳江","阳泉","扬州","烟台","宜宾","宜昌","宜春","营口","益阳","永州","岳阳","榆林","运城","云浮","玉树","玉溪","玉林"],["张家口","镇江","舟山","漳州","淄博","枣庄","郑州","周口","驻马店","株洲","张家界","珠海","湛江","肇庆","中山","自贡","资阳","遵义","昭通","张掖","中卫","诸暨","章丘","中沙"]]
    }
    
    func createTableView() {
        tableView = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H-64-49), style: UITableViewStyle.Plain)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

    }

}
extension RegionViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataArr.count
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        let sectionArray = self.dataArr.objectAtIndex(section) as! [AnyObject]
        return sectionArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("city")
        if cell == nil {
            cell = UITableViewCell.init(style: .Default, reuseIdentifier: "city")
        }
        let array = self.dataArr.objectAtIndex(indexPath.section) as! NSArray
        let model = array[indexPath.row] as! String
        cell?.textLabel?.text = model
        return cell!
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let array = self.dataArr.objectAtIndex(indexPath.section) as! NSArray
        let model = array[indexPath.row] as! String
        delegate?.sendText(model)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewS = UIView.init(frame: CGRectMake(0, 0, SCREEN_W, 20))
        viewS.backgroundColor = GRAYCOLOR2
        let label = UILabel.init(frame: CGRectMake(20, 10, SCREEN_W, 20))
        label.font = UIFont.boldSystemFontOfSize(16)
        
        let arr = ["热门城市","A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","T","W","X","Y","Z"]
        for i in 0...23{
            if section == i{
            label.text = arr[i]
            }
        }
        viewS.addSubview(label)
        return viewS
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

