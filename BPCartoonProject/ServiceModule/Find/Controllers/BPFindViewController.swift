//
//  BPFindViewController.swift
//  BPCartoonProject
//
//  Created by baipeng on 2019/7/8.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class BPFindViewController: BPBaseViewController {
    private var banner:BPBannerView?
    private var navView:UIView?
    private var searchBackView:UIView?
    private var searchBar:UISearchBar?
    private var dataArray = [ModulesModel]()


    //MARK: - life cyle 1、控制器生命周期
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        createSubViewUI()
        refreshData()
        loadData()

    }

    //MARK: - 2、不同业务处理之间的方法以

    //MARK: - Network 3、网络请求
    func refreshData() {
        self.tableView.refreshHeader = BPRefreshHeader{[weak self] in self?.loadData()}
    }
    func loadData(){
        ApiLoadingProvider.request(UApi.findList, model: FindDataModel.self) { (returnData) in
            self.tableView.refreshHeader.endRefreshing()
            self.banner?.itemsArray = returnData?.galleryItems
            self.dataArray = (returnData?.modules)!
            self.tableView.reloadData()
        }
    }
    //MARK: - Action Event 4、响应事件

    @objc func cancenBtnAction() {

    }

    //MARK: - Call back 5、回调事件

    //MARK: - Delegate 6、代理、数据源


    //MARK: - interface 7、UI处理
    func createSubViewUI() {
        //头
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenWidth))
        self.tableView.tableHeaderView = view
        self.banner = BPBannerView.init(frame: view.bounds)
        view.addSubview(self.banner!)


        navView = UIView.init(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KNavigationBarHeight+KScale(50)))
        navView?.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        self.view.addSubview(navView!)

        let msgBtn = UIButton.init(type: .custom)
        msgBtn.adjustsImageWhenHighlighted = false
        msgBtn.frame = CGRect(x: KStatusBarHeight, y: KStatusBarHeight, width: KNavBarHeight, height: KNavBarHeight)
        msgBtn.setImage(UIImage.init(named: "message_privateLetter"), for: .normal)
        navView?.addSubview(msgBtn)



        searchBackView = UITextField.init(frame: CGRect(x: msgBtn.frame.maxX + KScale(10), y: KStatusBarHeight, width: KScreenWidth - KStatusBarHeight - KNavBarHeight - KScale(20), height: KNavBarHeight))
        searchBackView?.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        searchBackView?.layer.masksToBounds = true
        searchBackView?.layer.cornerRadius = CGFloat(KNavBarHeight / 2)
        navView?.addSubview(searchBackView!)

        searchBar = UISearchBar.init(frame:CGRect(x: 0, y: 10, width: searchBackView!.bounds.size.width, height: KNavBarHeight - 20))
        searchBar?.backgroundColor = UIColor.clear
        searchBar?.isTranslucent = false
        searchBar?.returnKeyType = .search
        searchBar?.autocorrectionType = .no
        searchBar?.autocapitalizationType = .none
        searchBar?.placeholder = "请输入名称"
        searchBar?.barTintColor = UIColor.clear
        searchBar?.keyboardType = .default
        searchBar?.showsCancelButton = true
        searchBar?.searchBarStyle = .prominent// 搜索框样式
        searchBar?.tintColor = UIColor.gray////光标
        searchBackView?.addSubview(searchBar!)


        for subsView:UIView in searchBar!.subviews {
            for sub:UIView in subsView.subviews{
                if sub.isEqual(NSClassFromString("UINavigationButton")) {
                    sub.frame.size.height = 45
                    sub.frame.size.width = KScreenWidth * 0.15
                    let btn:UIButton = sub as! UIButton
                    btn.backgroundColor = UIColor.clear
                    btn.setTitleColor(UIColor.black, for: .normal)
                    btn.setTitle("取消", for: .normal)
                    btn.addTarget(self, action: #selector(cancenBtnAction), for: .touchUpInside)
                }
            }
        }


    }

    //MARK: - lazy loading 8、懒加载
    private lazy var tableView : UITableView = {
        let tabView = UITableView.init(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight - KTabBarHeight), style: .grouped)
        tabView.delegate = self
        tabView.dataSource = self
        tabView.register(BPFindModuleType1Cell.self, forCellReuseIdentifier: "BPFindModuleType1Cell")
        tabView.register(BPFindModuleType2Cell.self, forCellReuseIdentifier: "BPFindModuleType2Cell")
        tabView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return tabView
    }()


}

///MARK: - tableViewDelegate 代理回调
extension BPFindViewController : UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let moduleModel = self.dataArray[indexPath.row]
        if moduleModel.uiType == 1 {
            return BPFindModuleType1Cell.cellHeight(self.dataArray[indexPath.row])
        }else if moduleModel.uiType == 4 {
            return BPFindModuleType2Cell.cellHeight(self.dataArray[indexPath.row])
        }
        return 0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moduleModel = self.dataArray[indexPath.row]
        if moduleModel.uiType == 1 {
            let cell:BPFindModuleType1Cell = tableView.dequeueReusableCell(withIdentifier: "BPFindModuleType1Cell", for: indexPath) as! BPFindModuleType1Cell
            cell.moduleModel = self.dataArray[indexPath.row]
            return cell
        }else if moduleModel.uiType == 4 {
            let cell:BPFindModuleType2Cell = tableView.dequeueReusableCell(withIdentifier: "BPFindModuleType2Cell", for: indexPath) as! BPFindModuleType2Cell
            cell.moduleModel = self.dataArray[indexPath.row]
            return cell
        }


        return UITableViewCell.init()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("123")
    }

}

//MARK:ScrollViewDelegate
extension BPFindViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar?.endEditing(false)

        var offsetY = scrollView.contentOffset.y / (KNavigationBarHeight + KScale(50))
        print(offsetY)

        let tempWidth = KScreenWidth - KStatusBarHeight - KNavBarHeight - KScale(20)
        var height = KScale(50)
        var width = tempWidth
        if offsetY <= 0.0 {
            offsetY = 0.1
            height = KScale(50)
            width = tempWidth
        }else if offsetY >= 1.0 {
            offsetY = 1.0
            height = 0
            width = tempWidth/2
        }else{
            if Int(scrollView.contentOffset.y) < Int(KNavigationBarHeight) {
                height =  KNavigationBarHeight - scrollView.contentOffset.y
                width = tempWidth / (offsetY*10)
            }else{
                height = 0
                width = tempWidth/2
            }
        }
        if width > tempWidth {
            width = tempWidth
        }else if width < tempWidth / 2{
            width = tempWidth/2
        }
        navView?.backgroundColor = UIColor.white.withAlphaComponent(offsetY)
        navView?.frame.size.height = KNavigationBarHeight + height
        searchBackView?.frame.size.width = width
    }
}
