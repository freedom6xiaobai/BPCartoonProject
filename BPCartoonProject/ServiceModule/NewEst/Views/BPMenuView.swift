//
//  BPMenuView.swift
//  BPCartoonProject
//
//  Created by baipeng on 2019/7/9.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

protocol MenuViewDelegate : NSObjectProtocol {
    func menuBar(from:NSInteger,to:NSInteger)
}

class BPMenuView: UIView {

    //MARK: - life cyle 1、初始化方法
    override func layoutSubviews() {
        super.layoutSubviews()

        let w = NSInteger(KScreenWidth) / self.titleArray.count
        for i in 0..<self.titleArray.count {
            let label = self.titleArray[i]
            label.frame = CGRect(x: w * i, y: 0, width: w, height: 50)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        let titles = ["周一","周二","周三","周四","周五","周六","周日"]
        for i in 0..<titles.count {
            let label = UILabel.init()
            label.isUserInteractionEnabled = true
            label.textAlignment = NSTextAlignment.center
            label.textColor = UIColor.black
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.tag = 1000+i
            label.text = titles[i]
            self.addSubview(label)

            let tap = UITapGestureRecognizer(target: self, action: #selector(labelTapAction(_:)))
            label.addGestureRecognizer(tap)

            self.titleArray.append(label)
        }

        let linew = NSInteger(KScreenWidth) / self.titleArray.count

        self.sliderView = UIView.init()
        self.sliderView.frame = CGRect(x: linew, y: 48, width: linew, height: 2)
        self.sliderView.backgroundColor = UIColor.white
        self.addSubview(self.sliderView)

        let line = UIView.init()
        line.backgroundColor = UIColor.red
        line.frame = CGRect(x: (linew - 25)/2, y: 0, width: 25, height: 1)
        self.sliderView.addSubview(line)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - 2、不同业务处理之间的方法以

    //MARK: - Network 3、网络请求

    //MARK: - Action Event 4、响应事件
    //
    @objc func labelTapAction(_ tap:UITapGestureRecognizer) {
        guard let tap = tap.view else { return }
        let index:NSInteger = tap.tag - 1000
        do{
            delegate?.menuBar(from: fromIndex, to: index)
        }
        fromIndex = index
    }
    //MARK: - Call back 5、回调事件
    func setSelectedTitleIndex(index:NSInteger) {
        for i in 0..<self.titleArray.count {
            let label = self.titleArray[i]
            label.textColor = UIColor.black
        }
        let selectedLabel = self.titleArray[index]
        selectedLabel.textColor = UIColor.red

        let w = NSInteger(KScreenWidth) / self.titleArray.count
        self.sliderView.frame = CGRect(x: index * w, y: 48, width: w, height: 2)
    }

    //MARK: - Delegate 6、代理、数据源

    //MARK: - interface 7、UI处理

    //MARK: - lazy loading 8、懒加载
    lazy var titleLabel = UILabel.init()
    private lazy var titleArray:[UILabel] = [UILabel]()
    lazy var sliderView = UIView.init()
    weak var delegate:MenuViewDelegate?
    private var fromIndex:NSInteger = 0

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
