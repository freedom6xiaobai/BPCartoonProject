//
//  UIRefresh.swift
//  BPCartoonProject
//
//  Created by baipeng on 2019/7/8.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit
import MJRefresh

extension UIScrollView {
    var refreshHeader: MJRefreshHeader {
        get { return mj_header }
        set { mj_header = newValue }
    }

    var refreshFooter: MJRefreshFooter {
        get { return mj_footer }
        set { mj_footer = newValue }
    }
}

class BPRefreshHeader: MJRefreshGifHeader {
    override func prepare() {
        super.prepare()
        setImages([UIImage(named: "refresh_normal")!], for: .idle)
        setImages([UIImage(named: "refresh_will_refresh")!], for: .pulling)
        setImages([UIImage(named: "refresh_loading_1")!,
                   UIImage(named: "refresh_loading_2")!,
                   UIImage(named: "refresh_loading_3")!], for: .refreshing)

        lastUpdatedTimeLabel.isHidden = true
        stateLabel.isHidden = true
    }
}

class BPRefreshAutoHeader: MJRefreshHeader {}

class BPRefreshFooter: MJRefreshBackNormalFooter {}

class BPRefreshAutoFooter: MJRefreshAutoFooter {}


class BPRefreshDiscoverFooter: MJRefreshBackGifFooter {

    override func prepare() {
        super.prepare()
        backgroundColor = UIColor.init(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1)
        setImages([UIImage(named: "refresh_discover")!], for: .idle)
        stateLabel.isHidden = true
        refreshingBlock = { self.endRefreshing() }
    }
}

class BPRefreshTipKissFooter: MJRefreshBackFooter {

    lazy var tipLabel: UILabel = {
        let tl = UILabel()
        tl.textAlignment = .center
        tl.textColor = UIColor.lightGray
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.numberOfLines = 0
        return tl
    }()

    lazy var imageView: UIImageView = {
        let iw = UIImageView()
        iw.image = UIImage(named: "refresh_kiss")
        return iw
    }()

    override func prepare() {
        super.prepare()
        backgroundColor = UIColor.init(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1)
        mj_h = 240
        addSubview(tipLabel)
        addSubview(imageView)
    }

    override func placeSubviews() {
        tipLabel.frame = CGRect(x: 0, y: 40, width: bounds.width, height: 60)
        imageView.frame = CGRect(x: (bounds.width - 80 ) / 2, y: 110, width: 80, height: 80)
    }

    convenience init(with tip: String) {
        self.init()
        refreshingBlock = { self.endRefreshing() }
        tipLabel.text = tip
    }
}



