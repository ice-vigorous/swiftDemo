//
//  MineWorksViewController.swift
//  Challenge
//
//  Created by ice on 2020/3/16.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class MineWorksViewController: UIBaseViewController {
    let cellVM = MineWorksVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isHidden = false
        self.title = "我的作品"
        // Do any additional setup after loading the view.
    }
    

    override func configUI() {
        setUpWorksHeader()
        setUpWorksList()
    }
    
    override func bindData() {

        cellVM.getWorksList(page: 10).subscribe(onNext: { dataArray in
            self.myWorksHeader.text = "我的全部作品(\(dataArray.count))"
            self.worksTableview.reloadData()
        })
        
    }
    
    // MARK: ----- 列表布局
    func setUpWorksList() {
        self.view.addSubview(worksTableview)
    }
    
    // MARK: ----- header布局
    func setUpWorksHeader() {
        self.view.addSubview(myWorksHeaderView)
        myWorksHeaderView.addSubview(myWorksHeader)
        myWorksHeaderView.snp.makeConstraints { (item) in
            item.left.right.top.equalTo(self.view)
            item.height.equalTo(50)
        }
        myWorksHeader.snp.makeConstraints { (item) in
            item.centerY.equalTo(myWorksHeaderView)
            item.left.equalTo(myWorksHeaderView.snp_left).offset(kCellLeftMargin)
            item.right.equalTo(myWorksHeaderView.snp_right).offset(kCellLeftMargin)
            item.height.equalTo(20)
        }
    }
    
    lazy var myWorksHeader:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: kCellTitleFont)
        label.textAlignment = .left
        return label
    }()
    
    lazy var myWorksHeaderView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    lazy var worksTableview:UITableView = {
        let tab = UITableView(frame: CGRect.init(x: 0, y: 50, width: kScreenWidth, height: kScreenHeight - 50), style: .plain)
        tab.register(cellType: MineWorksCell.self)
        tab.separatorStyle = .none
        tab.delegate = self
        tab.dataSource = self
        return tab
    }()
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension MineWorksViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellVM.cellHeight
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellVM.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MineWorksCell = tableView.dequeueReusableCell(for: indexPath, cellType: MineWorksCell.self)
        cell.loadData(model: cellVM.dataArray[indexPath.row])
        return cell
    }
    
    
}
