//
//  DogDetailViewController.swift
//  LoveDog
//
//  Created by wei on 16/8/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import FMDB

class DogDetailViewController: UIViewController,IFlySpeechSynthesizerDelegate {
    
    var model = DogModel()
    var scrollView = UIScrollView()//整个页面可以滚动
    var imageView = UIImageView()//上面的大图展示
    var lable = UILabel()//下面的文字展示
    var nameLabel = UILabel()//狗的名字
    
    //增加分享按钮
    var rightItem: UIBarButtonItem?
    var shareTitle:String?
    var shareUrl:String?
    var isCollect = false//收藏状态
    
    //增加语音合成功能
    var midItem:UIButton?
    var isSpeech = false//播放语音状态
    var iflySpeechSynthesizer = IFlySpeechSynthesizer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        for model1 in FMDBDataManager.defaultManger.selectAll(){
            if model1.id == model.id {
                isCollect = true
                break
            }
        }
        
        self.createScrollView()
        
        //增加分享功能
        rightItem = UIBarButtonItem.init(title: "分享", style: .plain, target:self, action: #selector(self.shareTo))
        rightItem?.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = rightItem
        
        //语音合成按钮
        midItem = UIButton.init(type: .system)
        midItem!.frame = CGRect(x: 0, y: 100, width: 30, height: 25)
        midItem?.center = CGPoint(x: SCREEN_W / 2, y: 30)
        midItem?.addTarget(self, action: #selector(self.speechSyn), for: .touchUpInside)
        midItem?.setImage(UIImage(named: "615-sound-2")?.withRenderingMode(.alwaysOriginal), for: UIControlState())
        self.navigationItem.titleView = midItem
//        self.view.addSubview(midItem!)
        
        self.createSpeech()
        
    }
    
    //分享
    func shareTo(){
        
        shareTitle = model.name
        shareUrl = model.imgUrl
        
        let shareParames = NSMutableDictionary()
        shareParames.ssdkSetupShareParams(byText: "骨小八狗狗图片分享", images: UIImage.init(named: "graylogo"), url: URL.init(string: shareUrl!), title: shareTitle, type: SSDKContentType.auto)
        //        ,SSDKPlatformType.TypeQQ.rawValue
        ShareSDK.showShareActionSheet(view, items: [SSDKPlatformType.typeWechat.rawValue], shareParams: shareParames) { (state, platformType, userdata, contentEnity, error, end) in
            switch state {
            case SSDKResponseState.success:
                print("分享成功")
            case SSDKResponseState.fail:
                print("分享失败")
            case SSDKResponseState.cancel:
                print("取消分享")
            default:
                break
            }
        }
    }
    
    func createScrollView(){
        scrollView.frame = UIScreen.main.bounds
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        imageView.frame = CGRect(x: 3, y: 0, width: SCREEN_W - 6, height: 250)
        scrollView.addSubview(imageView)
        imageView.sd_setImage(with: URL.init(string: model.imgUrl!))
        
        //遮挡网络图片上的logo
        let coverView = UIView()
        coverView.backgroundColor = UIColor.white
        coverView.frame = CGRect(x: 0, y: 230, width: SCREEN_W - 6, height: 20)
        imageView.addSubview(coverView)
        
        nameLabel.frame = CGRect(x: 11, y: CGFloat(imageView.frame.origin.y + 250), width: SCREEN_W - 30, height: 20)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        //因为在屏幕尺寸比较小的情况下，dogname会出边框
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.text = model.name
        scrollView.addSubview(nameLabel)
        
        //收藏按钮
        let button = UIButton.init(type: .system)
        button.frame = CGRect(x: SCREEN_W - 33, y: CGFloat(imageView.frame.origin.y + 250), width: 20, height: 20)
        button.tintColor = UIColor.red
        if isCollect {
            button.setImage(UIImage.init(named: "748-heart-toolbar-selected")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
        }else{
            button.setImage(UIImage.init(named: "748-heart-toolbar"), for: UIControlState())
        }
        button.addTarget(self, action: #selector(self.collectDog(_:)), for: .touchUpInside)
        scrollView.addSubview(button)
        
        lable.frame = CGRect(x: 10, y: CGFloat(imageView.frame.origin.y + 290), width: SCREEN_W - 20, height: 250)
        lable.text = model.details
        lable.font = UIFont.init(name: "STHeitiSC-Light", size: 17)//设置字体
        lable.textColor = TEXTGRYCOLOR
        lable.numberOfLines = 0
        lable.sizeToFit()
        scrollView.addSubview(lable)
        
        scrollView.contentSize = CGSize(width: 0, height: imageView.frame.height + lable.frame.height + 50 )
        
    }
    
    //收藏功能
    func collectDog(_ button:UIButton){
        //被选中
        isCollect = !isCollect
        if isCollect {
            button.setImage(UIImage.init(named: "748-heart-toolbar-selected")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
            FMDBDataManager.defaultManger.insertWith(model)
            
        }else{
            button.setImage(UIImage.init(named: "748-heart-toolbar"), for: UIControlState())
            FMDBDataManager.defaultManger.deleteSql(model, uid: model.id!)
        }
    }
    
    
    //语音合成按钮
    func speechSyn(_ button:UIButton){
        
        isSpeech = !isSpeech
        
        if isSpeech {
            iflySpeechSynthesizer.startSpeaking(self.lable.text)
        }else {
            iflySpeechSynthesizer.pauseSpeaking()
        }
    }
    
    //语音合成
    func createSpeech(){
        let initString =  String.init(format: "appid = %@", "57da6a66")
        IFlySpeechUtility.createUtility(initString)
        //        返回合成对象的单例
        IFlySpeechSynthesizer.sharedInstance()
        iflySpeechSynthesizer.delegate = self
        
        //设置语音合成的参数
        //合成的语速,取值范围 0~100
        iflySpeechSynthesizer.setParameter("50", forKey: IFlySpeechConstant.speed())
        iflySpeechSynthesizer.setParameter("50", forKey: IFlySpeechConstant.volume())
        //发音人,默认为”xiaoyan”;可以设置的参数列表可参考个性化发音人列表
        iflySpeechSynthesizer.setParameter("xiaoyan", forKey: IFlySpeechConstant.voice_NAME())
        //合成、识别、唤醒、评测、声纹等业务采样率
        iflySpeechSynthesizer.setParameter("8000", forKey: IFlySpeechConstant.sample_RATE())
        
        //asr_audio_path保存录音文件路径，如不再需要，设置value为nil表示取消，默认目录是d
        
        iflySpeechSynthesizer.setParameter("tts.pcm", forKey: IFlySpeechConstant.tts_AUDIO_PATH())

    }
    
    //   语音合成的结束回调
    func onCompleted(_ error:IFlySpeechError){
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

