//
//  BPFindViewController.swift
//  BPCartoonProject
//
//  Created by baipeng on 2019/7/8.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class BPFindViewController: BPBaseViewController {
    private lazy var tableView : UITableView = {
        let tabView = UITableView.init(frame: self.view.frame, style: .plain)
        tabView.delegate = self
        tabView.dataSource = self
        tabView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        return tabView
    }()

    private let titleArray = ["有妖气漫画", "网易二次元"]


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "YYSwiftProject"
        self.view.addSubview(self.tableView)
    }
}


extension BPFindViewController : UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }

  
}
