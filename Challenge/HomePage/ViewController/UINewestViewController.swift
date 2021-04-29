//
//  UINewestViewController.swift
//  Challenge
//
//  Created by ice on 2020/3/11.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import RxSwift
import MJRefresh

class UINewestViewController: UIBaseViewController {
    let viewModel = NewestViewModel()
    let disposeBag = DisposeBag()
    
    lazy var listView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.register(cellType: UIHPContentCell.self)
        tableView.register(headerFooterViewType: UINewestFooterView.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.mj_header = MJRefreshNormalHeader()
        tableView.mj_header?.setRefreshingTarget(self, refreshingAction: #selector(loadData))
        tableView.mj_footer = MJRefreshBackNormalFooter()
        tableView.mj_footer?.setRefreshingTarget(self, refreshingAction: #selector(loadMoreData))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        loadData()
        observableChange()
    }
    
    override func configUI() {
        view.addSubview(listView)
        listView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(kNavBarHeight)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(kScreenHeight - kNavBarHeight - kTabBarHeight)
        }
    }
    @objc override func loadData() {
        viewModel.requestNewestContent(1, per_page: 10, sort: 5)
    }
    @objc override func loadMoreData() {
        viewModel.requestNewestContent(10, per_page: 10, sort: 5)
    }
}

extension UINewestViewController {
    fileprivate func observableChange() {
        viewModel.dataSource.asObservable().subscribe(onNext: { [weak self] (model) in
            self?.listView.mj_header?.endRefreshing()
            self?.listView.reloadData()
            self?.listView.mj_footer?.endRefreshing()
        }).disposed(by: disposeBag)
    }
}

extension UINewestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataSource.value.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 1))
        return view
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UIHPContentCell.self)
        cell.setModel(self.viewModel.dataSource.value[indexPath.row])
        return cell
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(UINewestFooterView.self)
        footerView?.setModel(model: self.viewModel.dataSource.value[section].activity!)
        return footerView
        
    }
    //MARK: - 点击事件
}
