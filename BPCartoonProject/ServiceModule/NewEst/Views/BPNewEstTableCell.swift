//
//  BPNewEstTableCell.swift
//  BPCartoonProject
//
//  Created by baipeng on 2019/7/8.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit
import KingfisherWebP

class BPNewEstTableCell: UITableViewCell {

    //MARK: - life cyle 1、初始化方法
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.mainImageView)
        self.mainImageView.frame = CGRect(x: 10, y: 10, width: KScreenWidth-20, height: KScreenWidth-20)
        self.addSubview(self.button)
        self.button.frame = CGRect(x: 10, y: self.mainImageView.frame.maxY+5, width: 100, height: 40)
        self.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: self.button.frame.maxX + 10, y: self.button.frame.minY , width: KScreenWidth - self.button.frame.maxX - 20, height: 40)
    }

    //MARK: - 2、不同业务处理之间的方法以
    var model:DayItemModel?{
        didSet{
            guard let model = model else {return}

            self.mainImageView.kf.setImage(with: URL(string: model.cover!), placeholder: nil, options:[.processor(WebPProcessor.default), .cacheSerializer(WebPSerializer.default)], progressBlock: nil, completionHandler: nil)

            self.titleLabel.text = "\(String(describing: model.comicName!)) 最新:\(String(describing: model.description!))"

        }
    }
    //MARK: - Network 3、网络请求

    //MARK: - Action Event 4、响应事件
    //点击
    @objc func btnAciton(btn:UIButton) {
        print("ddddd")
    }
    //MARK: - Call back 5、回调事件

    //MARK: - Delegate 6、代理、数据源

    //MARK: - interface 7、UI处理

    //MARK: - lazy loading 8、懒加载
    lazy var mainImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 20.0
        imgView.contentMode = UIView.ContentMode.scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()

    lazy var button: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = DominantColor
        btn.setTitle("阅读漫画", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(btnAciton), for: .touchUpInside)
        return btn
    }()

    lazy var titleLabel:UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        return label;
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
