//
//  BPNavigationViewController.swift
//  BPCartoonProject
//
//  Created by baipeng on 2019/7/8.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class BPNavigationViewController: UINavigationController {

    //MARK: - life cyle 1、控制器生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarAppearence()
     }

}

func setNavBarAppearence()
{
    // 设置导航栏的主题
    let bar = UINavigationBar.appearance()
    bar.titleTextAttributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20),NSAttributedString.Key.foregroundColor:UIColor.white]//字体，颜色
//    bar.setBackgroundImage(UIImage.init(), for: UIBarPosition.topAttached, barMetrics: UIBarMetrics.default)
//    bar.shadowImage = UIImage.init()
    bar.barTintColor = UIColor.red//背景


}

extension BPNavigationViewController
{
    override func pushViewController(_ viewController: UIViewController, animated: Bool)
    {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
