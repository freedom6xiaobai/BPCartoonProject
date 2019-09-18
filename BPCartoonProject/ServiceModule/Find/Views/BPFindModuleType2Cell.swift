//
//  BPFindModuleType2Cell.swift
//  BPCartoonProject
//
//  Created by baipeng on 2019/7/11.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class BPFindModuleType2Cell: UITableViewCell, UICollectionViewDelegate,
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    //MARK: 变量
    private var iconImgView:UIImageView?
    private var titleLabel:UILabel?
    private var rightBtn:UIButton?
    private var collectionView:UICollectionView?
    private var layout:UICollectionViewFlowLayout?

    //MARK: - life cyle 1、初始化方法
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = UITableViewCell.SelectionStyle.none

        iconImgView = UIImageView.init(frame: CGRect(x: KScale(10), y: KScale(10), width: KScale(30), height: KScale(30)))
        iconImgView?.contentMode = UIView.ContentMode.scaleToFill
        self.contentView.addSubview(iconImgView!)

        titleLabel = UILabel.init(frame: CGRect(x: KScale(40), y: KScale(10), width: KScreenWidth / 2, height: KScale(30)))
        titleLabel?.font = KFont(14)
        titleLabel?.textColor = KColorWithHex(0xdddddd)
        self.contentView.addSubview(titleLabel!)

        rightBtn = UIButton.init(type: .custom)
        rightBtn?.adjustsImageWhenHighlighted = false
        rightBtn?.frame = CGRect(x: KScreenWidth - KScale(40), y: KScale(10), width: KScale(30), height: KScale(30))
        rightBtn?.backgroundColor = UIColor.red
        self.contentView.addSubview(rightBtn!)

        layout = UICollectionViewFlowLayout.init()
        collectionView = UICollectionView.init(frame: CGRect(x: 0, y: KScale(50), width: KScreenWidth, height: 0), collectionViewLayout: layout!)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(BPFindModuleType2ContentCell.self, forCellWithReuseIdentifier: "BPFindModuleType2ContentCell")
        collectionView?.backgroundColor = UIColor.white
        self.contentView.addSubview(collectionView!)


    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    //MARK: - 2、不同业务处理之间的方法以

    var moduleModel:ModulesModel?{
        didSet{
            iconImgView?.kf.setImage(with: URL(string: moduleModel!.moduleInfo!.icon!))
            titleLabel?.text = moduleModel!.moduleInfo!.title!
            if moduleModel?.moduleType == 1{
                titleLabel?.isHidden = false
                iconImgView?.isHidden = false
                rightBtn?.isHidden = false
                collectionView?.frame.origin.y = KScale(50)
                collectionView?.frame.size.height = KScale(260)
                layout!.scrollDirection = UICollectionView.ScrollDirection.vertical
            }else{
                titleLabel?.isHidden = true
                iconImgView?.isHidden = true
                rightBtn?.isHidden = true
                collectionView?.frame.origin.y = 0
                collectionView?.frame.size.height = KScale(130)
                layout!.scrollDirection = UICollectionView.ScrollDirection.horizontal
            }
            collectionView?.reloadData()
        }
    }

    //高度
    class func cellHeight(_ moduleModel:ModulesModel?) -> CGFloat {
        if moduleModel?.moduleType == 1{
            return KScale(310)//50+5+120+10+120+5
        }else{
            return KScale(130)
        }
    }


    //MARK: - Network 3、网络请求

    //MARK: - Action Event 4、响应事件

    //MARK: - Call back 5、回调事件

    //MARK: - Delegate 6、代理、数据源
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.moduleModel!.items!.count > 0 {
            return self.moduleModel!.items!.count
        }else{
            return self.moduleModel!.item!.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell:BPFindModuleType2ContentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BPFindModuleType2ContentCell", for: indexPath) as! BPFindModuleType2ContentCell

        if self.moduleModel!.items!.count > 0 {
            let model = self.moduleModel?.items?[indexPath.row]
            cell.itemsModel = model?[Int(arc4random() % UInt32(model!.count))]
        }else{
            cell.itemModel = self.moduleModel?.item![indexPath.row]
        }

        return cell
    }

    ///MARK: --  collectionView大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.moduleModel!.items!.count > 0 {
            if indexPath.row == 0{
                return CGSize(width: KScreenWidth / 3 * 2 - KScale(20), height: KScale(120))
            }
            return CGSize(width: KScreenWidth / 3 - KScale(20), height: KScale(120))
        }else{
            return CGSize(width: KScreenWidth - KScale(20), height: KScale(120))
        }
    }

    ///MARK: --  collectionView之间最小列间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return KScale(10)
    }

    ///MARK: -- collectionView之间最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return KScale(10)
    }

    ///MARK: -- collectionView距离上左下右位置设置
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    ///MARK: -- collectionView 点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    //MARK: - interface 7、UI处理

    //MARK: - lazy loading 8、懒加载


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



class BPFindModuleType2ContentCell: UICollectionViewCell {
    //
    private var imageView:UIImageView?
    private var titleLabel:UILabel?
    private var subLabel:UILabel?

    //MARK: - life cyle 1、初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height-KScale(20)))
        imageView?.clipsToBounds = true
        imageView?.contentMode = UIView.ContentMode.scaleAspectFill
        self.contentView.addSubview(imageView!)

        titleLabel = UILabel.init(frame: CGRect(x: 0, y: imageView!.frame.maxY, width: frame.width, height: KScale(12)))
        titleLabel?.font = KFont(12)
        titleLabel?.textColor = KBlackColor
        self.contentView.addSubview(titleLabel!)

        subLabel = UILabel.init(frame: CGRect(x: 0, y: titleLabel!.frame.maxY, width: frame.width, height: KScale(8)))
        subLabel?.font = KFont(8)
        subLabel?.textColor = KColorWithHex(0xF3F3F3)
        self.contentView.addSubview(subLabel!)


    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - 2、不同业务处理之间的方法以
    var itemsModel:ItemsModel?{
        didSet{
            titleLabel?.isHidden = false
            subLabel?.isHidden = false
            imageView?.kf.setImage(with: URL(string: itemsModel!.cover!))
            titleLabel!.text = itemsModel?.title
            subLabel!.text = itemsModel?.subTitle
        }
    }
    var itemModel:ItemsModel?{
        didSet{
            titleLabel?.isHidden = true
            subLabel?.isHidden = true
            imageView?.kf.setImage(with: URL(string: itemModel!.cover!))
        }
    }


    //MARK: - Network 3、网络请求

    //MARK: - Action Event 4、响应事件

    //MARK: - Call back 5、回调事件

    //MARK: - Delegate 6、代理、数据源

    //MARK: - interface 7、UI处理

    //MARK: - lazy loading 8、懒加载

}
