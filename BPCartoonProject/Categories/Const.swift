//
//  Const.swift
//  BPCartoonProject
//
//  Created by baipeng on 2019/7/8.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import HandyJSON
import SkeletonView

//* 系统版本号
let KSystemVersion = UIDevice.current.systemVersion
// iPhone4
let IS_IPhone4 = (UIScreen.main.bounds.size.height == 480) ? true : false
//iPhone5 SE
let IS_IPhone5 = (UIScreen.main.bounds.size.height == 568) ? true : false
//iPhone6 6s 7 8
let IS_IPhone6 = (UIScreen.main.bounds.size.height == 667) ? true : false
//iPhone6p 7p 8p
let IS_IPhone6p = (UIScreen.main.bounds.size.height == 736) ? true : false
//iPhoneX
let IS_IPhoneX = (UIScreen.main.bounds.size.height == 812) ? true : false
//iPhoneX
let IS_IPhoneXRS = (UIScreen.main.bounds.size.height == 896) ? true : false


// 屏幕有关
let iPone5 = UIScreen.main.bounds.size.height == 568
let iPone6 = UIScreen.main.bounds.size.height == 667
let iPone6p = UIScreen.main.bounds.size.height == 736
let iPoneX = UIScreen.main.bounds.size.height == 812
let iPoneXRS = UIScreen.main.bounds.size.height == 896


//获取屏幕宽度与高度
let KScreenWidth = UIScreen.main.responds(to: #selector(getter: UIScreen.nativeBounds)) ? UIScreen.main.nativeBounds.size.width / UIScreen.main.nativeScale : UIScreen.main.bounds.size.width

let KScreenHeight = UIScreen.main.responds(to: #selector(getter: UIScreen.nativeBounds)) ? UIScreen.main.nativeBounds.size.height / UIScreen.main.nativeScale : UIScreen.main.bounds.size.height

let KScreenSize = UIScreen.main.responds(to: #selector(getter: UIScreen.nativeBounds)) ? CGSize(width: UIScreen.main.nativeBounds.size.width / UIScreen.main.nativeScale, height: UIScreen.main.nativeBounds.size.height / UIScreen.main.nativeScale) : UIScreen.main.bounds.size

let KDeviceIsiPhoneX = UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? CGSize(width: 1125, height: 2436).equalTo(UIScreen.main.currentMode!.size) : false

//判断当前是否为横屏
let isHorScreen = KScreenWidth > KScreenHeight

//* 设计图模型宽 这里以6s
let BPGIsPhoneWidth = 375.0
let BPGIsPhoneHeight = 667.0
//* 尺寸缩放
func KScale(_ f: CGFloat) -> CGFloat {
    return CGFloat(f) * (isHorScreen ? KScreenHeight : KScreenWidth) / CGFloat(BPGIsPhoneWidth)
}

//* 字体缩放，依据iphone6
func KScalefont(_ f: Any) -> UIFont {
    return UIFont.systemFont(ofSize: KScale(f as! CGFloat))
}
//*  非适配字体大小
func KFont(_ f: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: CGFloat(f))
}

//*  导航栏高度
let KNavBarHeight = CGFloat(44.0)
//* 标签栏高度
let KStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
//*  导航栏和标签栏高度
let KNavigationBarHeight = KStatusBarHeight + KNavBarHeight
//* 底部TabBar的高度
let KTabBarHeight = CGFloat(UIApplication.shared.statusBarFrame.size.height > 20 ? 83 : 49)
//* 底部安全区的高度
let KTabBarBottemSpace = CGFloat((IS_IPhoneX || IS_IPhoneXRS ) ? 34 : 0)
//
func KViewSafeAreInsets(_ view: Any) {
    var insets: UIEdgeInsets
    if #available(iOS 11.0, *) {
        insets = (view as AnyObject).safeAreaInsets
    } else {
        insets = .zero
    }
}

//颜色

func KRGBColor(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
    return UIColor(red: (r) / 255.0, green: (g) / 255.0, blue: (b) / 255.0, alpha: 1.0)
}

func KRGBAColor(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
    return UIColor(red: (r) / 255.0, green: (g) / 255.0, blue: (b) / 255.0, alpha: a)
}

let KRGBRandomColor = UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1.0)

func KColorWithHex(_ rgbValue: CGFloat) -> UIColor {
    return UIColor(red: CGFloat((Float((Int(rgbValue) & 0xff0000) >> 16)) / 255.0), green: CGFloat((Float((Int(rgbValue) & 0xff00) >> 8)) / 255.0), blue: CGFloat((Float(Int(rgbValue) & 0xff)) / 255.0), alpha: 1.0)
}

let DominantColor = UIColor.init(red: 239/255.0, green: 80/255.0, blue: 88/255.0, alpha: 1)

let FooterViewColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)

let KWhiteColor = UIColor.white

let KBlackColor = UIColor.black

let KClearColor = UIColor.clear

