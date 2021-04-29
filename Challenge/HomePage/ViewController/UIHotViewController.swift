//
//  UIHotViewController.swift
//  Challenge
//
//  Created by ice on 2020/3/11.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import RxSwift
import MJRefresh

class UIHotViewController: UIBaseViewController {
    
    let viewModel = ActivityViewModel()
    let disposeBag = DisposeBag()
    
    lazy var listView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: UIHPHotBannerCell.self)
        tableView.register(cellType: UIHPHotActivityCell.self)
        tableView.register(cellType: UIHPHotContentCell.self)
        tableView.register(cellType: UIHPContentCell.self)
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
    
    // MARK: - 布局
    override func configUI() {
        view.addSubview(listView)
        listView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(kNavBarHeight)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(kScreenHeight - kNavBarHeight - kTabBarHeight)
        }
    }
    
    // MARK: - 加载数据
    @objc override func loadData() {
        //加载网络
        viewModel.networkError.asObservable()
            .subscribe( onNext:{ error in
                
                print(error)
            }
        ).disposed(by: disposeBag)
        viewModel.requestBannSource(10)
        viewModel.requestHotActiSource(10)
        viewModel.requestHotContSource(10)
        viewModel.requestHotListSource(1, per_page: 10, sort: 5) 
    }
    
    //MARK: - 加载更多
    @objc override func loadMoreData() {
        viewModel.requestHotListSource(10, per_page: 10, sort: 5)
    }
}

extension UIHotViewController {
    fileprivate func observableChange() {
        Observable.merge(viewModel.hotBannSource.asObservable(), viewModel.hotActiSource.asObservable(), viewModel.hotContSource.asObservable()).subscribe(onNext: { [weak self] (model) in
            self?.listView.mj_header?.endRefreshing()
            self?.listView.reloadData()
            //self?.listView.mj_footer?.endRefreshing()
        }).disposed(by: disposeBag)
        viewModel.hotListSource.asObservable().subscribe(onNext: { [weak self] (model) in
//            self?.listView.mj_header?.endRefreshing()
            self?.listView.reloadData()
            self?.listView.mj_footer?.endRefreshing()
        }).disposed(by: disposeBag)
    }
}

extension UIHotViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return 1
        default: return self.viewModel.hotListSource.value.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productModel = self.viewModel.hotListSource.value[indexPath.row]
        if productModel.type == 2 {
            let contentVC = UIVideoContentController()
            contentVC.productModel = self.viewModel.hotListSource.value[indexPath.row]
            self.navigationController?.pushViewController(contentVC, animated: true)
        }else {

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            // 轮播
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UIHPHotBannerCell.self)
            cell.setModelArray(self.viewModel.hotBannSource.value)
            return cell
        case 1:
            // 热门活动
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UIHPHotActivityCell.self)
            cell.setModelArray(self.viewModel.hotActiSource.value)
            return cell
        case 2:
            // 热门内容
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UIHPHotContentCell.self)
            return cell
        default:
            // 首页内容
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UIHPContentCell.self)
            cell.setModel(self.viewModel.hotListSource.value[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 150
        case 1: return 90
        case 2: return 30
        default: return 250
        }
    }
}
