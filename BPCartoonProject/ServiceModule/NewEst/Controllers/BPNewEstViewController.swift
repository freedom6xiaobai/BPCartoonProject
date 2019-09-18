//
//  BPNewEstViewController.swift
//  BPCartoonProject
//
//  Created by baipeng on 2019/7/8.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class BPNewEstViewController: BPBaseViewController {

    //MARK: - life cyle 1、控制器生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "今日更新"
        createSubViewUI()
        self.view.addSubview(self.menuView)
        self.view.addSubview(self.scrollview)
        setupSubViewControllers()
        self.menuView.setSelectedTitleIndex(index: 0)
        self.scrollViewDidEndScrollingAnimation(self.scrollview)
    }

    //MARK: - 2、不同业务处理之间的方法以
    func setupSubViewControllers() {
        for _ in 0..<7 {
            let newBaseVC = BPNewBaseViewController.init()
            self.addChild(newBaseVC)
        }
    }
    //MARK: - Network 3、网络请求

    //MARK: - Action Event 4、响应事件
    ///点击搜索事件
    @objc func searchBtnAction(btn:UIButton) {
        print("searchBtnAction")
    }

    //MARK: - Call back 5、回调事件

    //MARK: - Delegate 6、代理、数据源

    //MARK: - interface 7、UI处理
    func createSubViewUI() {
        let btn = UIButton.init(type: .custom)
        btn.adjustsImageWhenHighlighted = false
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btn.setImage(UIImage(named: "search"), for: .normal)
        btn.addTarget(self, action: #selector(searchBtnAction), for: .touchUpInside)
        let bar = UIBarButtonItem.init(customView: btn)
        self.navigationItem.rightBarButtonItem = bar


    }

    //MARK: - lazy loading 8、懒加载
    lazy var menuView:BPMenuView = {
        let menu = BPMenuView.init(frame: CGRect(x: 0, y: KNavigationBarHeight, width: KScreenWidth, height: 50))
        menu.delegate = self
        return menu
    }()

    lazy var scrollview:UIScrollView = {
        let scroll = UIScrollView.init()
        scroll.frame = CGRect(x: 0, y: KNavigationBarHeight+50, width: KScreenWidth, height: KScreenHeight - 50 - KTabBarHeight  - KNavigationBarHeight)
        scroll.contentOffset = CGPoint(x: 0, y: 0)
        scroll.contentSize = CGSize(width: KScreenWidth * 7, height: KScreenHeight - 50 - KTabBarHeight - KNavigationBarHeight)
        scroll.isPagingEnabled = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.delegate = self
        return scroll
    }()
}

///MARK:ScrollViewDelegate
extension BPNewEstViewController:UIScrollViewDelegate{
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let offetX  = scrollview.contentOffset.x
        let index:NSInteger = NSInteger(offetX/KScreenWidth)
        let baseVC:BPNewBaseViewController = self.children[index] as! BPNewBaseViewController
        baseVC.indexDay = index
        self.menuView.setSelectedTitleIndex(index: index)
        if baseVC.isViewLoaded {
            return
        }

        baseVC.view.frame = CGRect(x: KScreenWidth * CGFloat(index), y: 0, width: self.scrollview.frame.width, height: self.scrollview.frame.height)
        self.scrollview.addSubview(baseVC.view)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self .scrollViewDidEndScrollingAnimation(scrollview)
        if !scrollView.isEqual(self.scrollview){
            return
        }
    }
}

extension BPNewEstViewController : MenuViewDelegate {
    func menuBar(from: NSInteger, to: NSInteger) {
        self.scrollview.setContentOffset(CGPoint(x: KScreenWidth * CGFloat(to), y: 0), animated: true)
    }
}
