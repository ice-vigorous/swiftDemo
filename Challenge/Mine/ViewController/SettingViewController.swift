//
//  SettingViewController.swift
//  Challenge
//
//  Created by ice on 2020/3/18.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit

class SettingViewController: UIBaseViewController {
    private let cellVM = SettingVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isHidden = false
        self.title = "设置"
        // Do any additional setup after loading the view.
    }
    
    override func configUI() {
        self.view.addSubview(settingTableview)
    }
    
    override func bindData() {
        cellVM.getDataArray().subscribe(onNext: { (item) in
            self.settingTableview.reloadData()
        }).dispose()
    }
    
    lazy var settingTableview:UITableView = {
        let tab = UITableView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .plain)
        tab.register(cellType: SettingCell.self)
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

extension SettingViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellVM.dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SettingCell = tableView.dequeueReusableCell(for: indexPath, cellType: SettingCell.self)
        cell.title.text = cellVM.dataArray[indexPath.row].title
        return cell
    }
    
}
