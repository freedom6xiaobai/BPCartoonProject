
//
//  BPBannerView.swift
//  BPCartoonProject
//
//  Created by baipeng on 2019/7/9.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit


class BPBannerBackView: UIView {
    var imageView: UIImageView?
    var label: UILabel?
    var subImgView: UIImageView?


    override init(frame: CGRect) {
        super.init(frame: frame)

        clipsToBounds = true

        imageView = UIImageView()
        imageView?.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: frame.size.height)
        self.addSubview(imageView!)

        let hintImgView = UIImageView()
        hintImgView.frame = CGRect(x: 0, y: frame.size.height - 100, width: KScreenWidth, height: 100)
        hintImgView.image = UIImage.init(named: "banner_back")
        self.addSubview(hintImgView)

        subImgView = UIImageView()
        subImgView?.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: frame.size.height)
        self.addSubview(subImgView!)

        label = UILabel()
        label?.textAlignment = .center
        label?.textColor = UIColor.white
        label?.font = UIFont.boldSystemFont(ofSize: 30)
        label?.frame = CGRect(x: 0, y: frame.size.height - KScale(70), width: KScreenWidth, height: KScale(40))
        addSubview(label!)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    var imageOffSetX:CGFloat? {
        didSet{
            self.imageView?.frame = CGRect(x: imageOffSetX!, y: 0, width: KScreenWidth, height: self.frame.size.height)

        }
    }

    var subImageOffSetX:CGFloat? {
        didSet{
            UIView.animate(withDuration: 0.2, animations: {
                self.subImgView?.frame = CGRect(x: -(self.subImageOffSetX! / 5), y: 0, width: KScreenWidth, height: self.frame.size.height)
            })
        }
    }
}


class BPBannerView: UIView,UIScrollViewDelegate{
    lazy var scrollView = UIScrollView.init()
    lazy var pageControl = UIPageControl.init()
    var timer:Timer?
    var starCurrentOffSetX:CGFloat = 0

    let AnimationOffset = KScale(100)


    //MARK: - life cyle 1、初始化方法
    override init(frame: CGRect) {
         super.init(frame: frame)
        self.backgroundColor = UIColor.white
        createSubViewUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 2、不同业务处理之间的方法以
    var itemsArray:[GalleryItemModel]?{
        didSet{
            self.scrollView.subviews.forEach { (subView) in
                subView.removeFromSuperview()
            }

            for idx in 0..<itemsArray!.count + 2 {
                let bannerBackView = BPBannerBackView.init(frame: CGRect(x: CGFloat(idx)*KScreenWidth, y: 0, width: KScreenWidth, height: KScreenWidth))
                self.scrollView.addSubview(bannerBackView)
                let tap = UITapGestureRecognizer.init(target: self, action: #selector(imageTapAction(_:)))
                bannerBackView.addGestureRecognizer(tap)

                var tag = 0;
                if (idx == 0) {
                    tag = itemsArray!.count;
                } else if (idx == itemsArray!.count + 1) {
                    tag = 1;
                } else {
                    tag = idx;
                }
                bannerBackView.tag = idx+100;

                let model = itemsArray![tag - 1]
                bannerBackView.label?.text = model.title ?? ""
                //-- layer添加阴影
                bannerBackView.label?.layer.shadowColor = UIColor.black.cgColor
                bannerBackView.label?.layer.shadowOffset = CGSize(width: 0, height: 0)
                bannerBackView.label?.layer.shadowRadius = 15
                bannerBackView.label?.layer.shadowOpacity = 1

                bannerBackView.imageView?.kf.setImage(with: URL(string: model.cover!))
                bannerBackView.subImgView?.kf.setImage(with: URL(string: model.topCover!))
            }

            self.scrollView.contentSize = CGSize(width: KScreenWidth * CGFloat(itemsArray!.count+2), height: KScreenWidth)
            self.scrollView.contentOffset = CGPoint(x: KScreenWidth, y: 0)
            self.pageControl.numberOfPages = itemsArray!.count


            //开启定时器
            removeTimer()
            addTimer()
        }
    }

    //MARK: - Network 3、网络请求

    //MARK: - Action Event 4、响应事件
    ///点击图片
    @objc func imageTapAction(_ tap:UITapGestureRecognizer) {
         print(tap.view?.tag)
    }

    //MARK: - Call back 5、回调事件
    ///MARK: - Timer
    func addTimer() {
        timer = Timer.init(timeInterval: 5, repeats: true, block: { (time) in
            self.nextImage()
        })
        RunLoop.current.add(timer!, forMode: RunLoop.Mode.common)
    }

    func removeTimer() {
        if timer != nil {
            timer!.invalidate()
        }
    }
    func nextImage() {
        let currentPage = self.pageControl.currentPage
        self.scrollView.setContentOffset(CGPoint(x: CGFloat(currentPage + 2) * KScreenWidth, y: 0), animated: true)

    }

    //MARK: - Delegate 6、代理、数据源
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollW = self.scrollView.frame.size.width;
        let currentPage:CGFloat = CGFloat(self.scrollView.contentOffset.x / scrollW);
        if (Int(currentPage) == self.itemsArray!.count + 1) {
            self.pageControl.currentPage = 0;
        } else if (currentPage == 0) {
            self.pageControl.currentPage = self.itemsArray!.count;
        } else {
            self.pageControl.currentPage = Int(currentPage - 1);
        }

        let offsetX = scrollView.contentOffset.x

        if Int(currentPage+1) >= scrollView.subviews.count {
             return
        }

        //-- leftView和rightView是滚动时可见的两个视图，一个当前视图，一个将要进入的视图
        let leftView:BPBannerBackView = scrollView.viewWithTag(Int(currentPage + 100)) as! BPBannerBackView
        let rightView:BPBannerBackView = scrollView.viewWithTag(Int(currentPage + 1 + 100)) as! BPBannerBackView
        //向右滑动，a为负值， 需要移动距离长度 +(偏移a值(KScreenWidth - AnimationOffset)比例上的值), 从a值开始太小，加上总移动位置=进行动画宽度
        //向左滑动，a为正值， -需要移动距离长度 +(偏移a值-(KScreenWidth - AnimationOffset)比例上的值),获得负的远距离x值=进行动画宽度小值
        if starCurrentOffSetX > offsetX {//向右
            NSLog("向右");
            let tempOffSetX = CGFloat(-(KScreenWidth - AnimationOffset)) + (offsetX - (currentPage * KScreenWidth)) / KScreenWidth * CGFloat((KScreenWidth - AnimationOffset))
            rightView.imageOffSetX = tempOffSetX
            rightView.subImageOffSetX = tempOffSetX
            leftView.imageOffSetX = 0
            leftView.subImageOffSetX = CGFloat((KScreenWidth - AnimationOffset)) + (offsetX - ((currentPage + 1) * KScreenWidth)) / KScreenWidth * CGFloat((KScreenWidth - AnimationOffset))
        }

        if starCurrentOffSetX < offsetX {//向左
            NSLog("向左");
            let tempOffSetX: CGFloat = CGFloat((KScreenWidth - AnimationOffset)) + (offsetX - ((currentPage + 1) * KScreenWidth)) / KScreenWidth * CGFloat((KScreenWidth - AnimationOffset))
            leftView.imageOffSetX = tempOffSetX
            leftView.subImageOffSetX = tempOffSetX
            rightView.imageOffSetX = 0
            rightView.subImageOffSetX = CGFloat(-(KScreenWidth - AnimationOffset)) + (offsetX - (currentPage * KScreenWidth)) / KScreenWidth * CGFloat((KScreenWidth - AnimationOffset))
        }

    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.scrollViewDidEndDecelerating(scrollView)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollW = self.scrollView.frame.size.width;
        let currentPage:Int = Int(self.scrollView.contentOffset.x / scrollW);

        if (currentPage == self.itemsArray!.count + 1) {
            self.pageControl.currentPage = 0;
            self.scrollView.setContentOffset(CGPoint(x: scrollW, y: 0), animated: false)
        } else if (currentPage == 0) {
            self.pageControl.currentPage = self.itemsArray!.count;
            self.scrollView.setContentOffset(CGPoint(x: CGFloat(self.itemsArray!.count) * scrollW, y: 0), animated: false)
        } else {
            self.pageControl.currentPage = currentPage - 1;
        }

        for view in scrollView.subviews {
            if view.isEqual(BPBannerBackView.self){
                let v:BPBannerBackView = view as! BPBannerBackView
                v.imageOffSetX = 0
                v.subImageOffSetX = 0
            }
        }
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
        starCurrentOffSetX = self.scrollView.contentOffset.x;
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        removeTimer()
        self.addTimer()
    }

    //MARK: - interface 7、UI处理
    func createSubViewUI() {
        self.scrollView.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenWidth)
        self.scrollView.delegate = self
        self.scrollView.isPagingEnabled = true
        self.scrollView.bounces = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(self.scrollView)

        self.pageControl.frame = CGRect(x: 0, y: KScreenWidth - 30, width: KScreenWidth/3, height: 30)
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.red
        self.addSubview(self.pageControl)

    }
    //MARK: - lazy loading 8、懒加载


}

