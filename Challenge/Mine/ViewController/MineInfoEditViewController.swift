//
//  MineInfoEditViewController.swift
//  Challenge
//
//  Created by ice on 2020/3/16.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class MineInfoEditViewController: UIBaseViewController {
    
    let cellVM = MineInfoCellVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isHidden = false
        self.title = "编辑个人资料"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func configUI() {
        setUpAvatar()
        setUpOtherTablebview()
    }
    
    override func bindData() {

        cellVM.getDataArray().subscribe(onNext: { (item) in
            self.otherTableview.reloadData()
        }).dispose()
    }
    
    // MARK: ----- 头像
    func setUpAvatar() {
        self.view.addSubview(avatar)
        
        avatar.snp.makeConstraints { (item) in
            item.width.height.equalTo(50)
            item.centerX.equalTo(self.view)
            item.centerY.equalTo(self.view.snp_top).offset(50)
        }
    }
    
    lazy var avatar:UIImageView = {
        let imageV = UIImageView()
        imageV.layer.cornerRadius = 25
        imageV.backgroundColor = UIColor.yellow
        return imageV
    }()
    
    // MARK: ----- 其他信息列表
    func setUpOtherTablebview() {
        self.view.addSubview(otherTableview)
    }
    
    lazy var otherTableview:UITableView = {
        let tab = UITableView(frame: CGRect.init(x: 0, y: 100, width: kScreenWidth, height: kScreenHeight), style: .plain)
        tab.register(cellType: MineInfoCell.self)
        tab.separatorStyle = .none
        tab.delegate = self
        tab.dataSource = self
        tab.isScrollEnabled = false
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

extension MineInfoEditViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellVM.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MineInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: MineInfoCell.self)
        if cellVM.dataArray[indexPath.row].title.isEmpty {
            
        }else{
            let str = cellVM.dataArray[indexPath.row].title
            let detail = cellVM.dataArray[indexPath.row].subDesc
            cell.title.text = str
            cell.detail.text = detail
        }
        return cell
    }
}

