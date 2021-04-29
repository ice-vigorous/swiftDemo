//
//  UIActicityViewController.swift
//  Challenge
//
//  Created by ice on 2020/3/19.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import RxSwift
import MJRefresh

class UIActicityDetailsController: UIBaseViewController {
    
    let viewModel = ActivityDetailsViewModel()
    let disposeBag = DisposeBag()
    
    var activityModel: ActivityModel!
    
    lazy var listView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.register(cellType: UIActicityDetailsCell.self)
        tableView.register(cellType: UIHPHotBannerCell.self)
        tableView.register(cellType: UIActiDetailsHotContentCell.self)
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
        loadData()
        observableChange()
    }
    override func configUI() {
        view.addSubview(listView)
        listView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kNavBarHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(kScreenHeight - kNavBarHeight - kTabBarHeight)
        }
    }
    
    @objc override func loadData() {
        viewModel.requestActivity(activityModel.int!)
        viewModel.requestActiDetailContent(activityModel.int!, page: 1, per_page: 10, sort: 5)
    }
    
    @objc override func loadMoreData() {
        viewModel.requestActiDetailContent(activityModel.int!, page: 10, per_page: 10, sort: 5)
    }
}

extension UIActicityDetailsController {
    fileprivate func observableChange() {
        Observable<Any>.zip(viewModel.activitySource.asObservable(), viewModel.contentSource.asObservable()).subscribe(onNext: { [weak self] (model) in
            self?.listView.mj_header?.endRefreshing()
            self?.listView.reloadData()
            //self?.listView.mj_footer?.endRefreshing()
        }).disposed(by: disposeBag)
        viewModel.contentSource.asObservable().subscribe(onNext: { [weak self] (model) in
            self?.listView.mj_header?.endRefreshing()
            self?.listView.reloadData()
            self?.listView.mj_footer?.endRefreshing()
        }).disposed(by: disposeBag)
    }
}

extension UIActicityDetailsController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UIActicityDetailsCell.self)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UIHPHotBannerCell.self)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UIActiDetailsHotContentCell.self)
            return cell
            
        }
    }
}
