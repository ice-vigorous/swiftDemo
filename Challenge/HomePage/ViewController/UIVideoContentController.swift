//
//  UIContentViewController.swift
//  Challenge
//
//  Created by ice on 2020/3/16.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import RxSwift

class UIVideoContentController: UIBaseViewController {
    var productModel: ProductsModel?
    
    let viewModel = DetailsViewModel()
    let disposeBag = DisposeBag()
    
    lazy var listView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.register(cellType: UICommentTableViewCell.self)
        tableView.register(headerFooterViewType: UIVideoContentHeaderView.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = 300
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        loadData()
        observableChange()
        // Do any additional setup after loading the view.
    }
    override func configUI() {
        view.addSubview(listView)
        listView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kNavBarHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(kScreenHeight - kNavBarHeight - kTabBarHeight)
        }
    }
    override func loadData() {
        viewModel.requestDetails(productModel!.id!)
    }
}

extension UIVideoContentController {
    fileprivate func observableChange() {
        viewModel.dataSource.asObservable().subscribe(onNext: { [weak self] (model) in
            self?.listView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension UIVideoContentController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UICommentTableViewCell.self)
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let headerView = tableView.dequeueReusableHeaderFooterView(UIVideoContentHeaderView.self)
            headerView?.setModel(self.viewModel.dataSource.value)
            return headerView
        default:
            return nil
        }
    }
//    // 自适应Header返回一个预估高度
//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        return 300
//    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return UITableView.automaticDimension
        default: return 0
        }
    }
}
