//
//  BPNewEstViewController.swift
//  BPCartoonProject
//
//  Created by baipeng on 2019/7/8.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class BPNewEstViewController: BPBaseViewController {
    private let cellIndentifier = "BPNewEstTableCell"
    private let FooterIndentifier = "U17TodayFooterView"
    private let HeaderIndentifier = "U17TodayHeaderView"

    private var page:Int = 0

    //MARK: - life cyle 1、控制器生命周期
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "今日更新"
        self.view.addSubview(tableView)
        createSubViewUI()
        loadData(more: false)
        refreshData()
    }

    //MARK: - 2、不同业务处理之间的方法以

    //MARK: - Network 3、网络请求
    ///刷新
    func refreshData() {
        self.tableView.refreshHeader = BPRefreshHeader{[weak self] in self?.loadData(more: false)}
        self.tableView.refreshFooter = BPRefreshFooter{[weak self] in self?.loadData(more: true)}
    }

    //网络请求数据
    func loadData(more:Bool) {
        page = (more ? (page + 1) : 0)
        ApiLoadingProvider.request(UApi.todayList(day: 1, page: page),model: DayDataModel.self) { [weak self](returnData) in
            //结束刷新
            self?.tableView.refreshHeader.endRefreshing()
            if returnData?.hasMore == false {
                self?.tableView.refreshFooter.endRefreshingWithNoMoreData()
            } else {
                self?.tableView.refreshFooter.endRefreshing()
            }
            if more == false { self?.dayDataList.removeAll() }
            self?.dayDataList.append(contentsOf: returnData?.comics ?? [])
            self?.tableView.reloadData()
        }
    }

    //MARK: - Action Event 4、响应事件

    //MARK: - Call back 5、回调事件
    ///点击搜索事件
    @objc func searchBtnAction(btn:UIButton) {
        print("searchBtnAction")
    }
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
    private lazy var tableView : UITableView = {
        let tabView = UITableView.init(frame: CGRect(x: 0, y: 64, width: KScreenWidth, height: KScreenHeigth - 49-64), style: .grouped)
        tabView.delegate = self
        tabView.dataSource = self
        tabView.backgroundColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        tabView.register(BPNewEstTableCell.self, forCellReuseIdentifier: cellIndentifier)
        tabView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return tabView
    }()

    private var dayDataList = [DayItemModel]()


}

///MARK: - tableViewDelegate 代理回调
extension BPNewEstViewController : UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dayDataList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KScreenWidth + 35
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:BPNewEstTableCell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath) as! BPNewEstTableCell
        cell.backgroundColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.model = self.dayDataList[indexPath.section]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("123")
    }

}


