//
//  BPTabBarViewController.swift
//  BPCartoonProject
//
//  Created by baipeng on 2019/7/8.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit



class BPTabBarViewController: UITabBarController {

    //MARK: - life cyle 1、控制器生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        tabBar.isTranslucent = false

        // 获取TabBarItem的appearence
        let appearance = UITabBarItem.appearance()
        //默认状态
        let normalDict:[NSAttributedString.Key:Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0)]
        //选中状态
        let selectDict:[NSAttributedString.Key:Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0)]

        appearance.setTitleTextAttributes(normalDict, for: .normal)
        appearance.setTitleTextAttributes(selectDict, for: .selected)

        //隐藏阴影线
        UITabBar.appearance().backgroundImage = UIImage.init()
        UITabBar.appearance().shadowImage = UIImage.init()
        UITabBar.appearance().barTintColor = UIColor.white //背景颜色为红色

        initChildViewController()
    }

    //MARK: - 2、不同业务处理之间的方法以
    func initChildViewController() {
        let newVC = BPNewEstViewController()
        addChildViewController(vc: newVC, title: "首页", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))

        let findVC = BPFindViewController()
        addChildViewController(vc: findVC, title: "发现", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))

        let bookVC = BPBookRackViewController()
        addChildViewController(vc: bookVC, title: "书架", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))

        let mineVC = BPMineViewController()
        addChildViewController(vc: mineVC, title: "我的", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))

    }

    //MARK: - Network 3、网络请求

    //MARK: - Action Event 4、响应事件


    //MARK: - Call back 5、回调事件
    func addChildViewController(vc:UIViewController,title:String?,image:UIImage?,selectedImage:UIImage?) {
        vc.title = title;
        vc.navigationItem.title = title;
        vc.tabBarItem = UITabBarItem(title: title, image: image?.withRenderingMode(.alwaysOriginal), selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        if UIDevice.current.userInterfaceIdiom == .phone {
            vc.tabBarItem.imageInsets = UIEdgeInsets(top: 1, left: 0, bottom: -1, right: 0)
        }
        addChild(BPNavigationViewController.init(rootViewController: vc))
    }
    //MARK: - Delegate 6、代理、数据源

    //MARK: - interface 7、UI处理

    //MARK: - lazy loading 8、懒加载


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
