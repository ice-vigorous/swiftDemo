//
//  UIMineViewController.swift
//  Challenge
//
//  Created by ice on 2020/3/11.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class UIMineViewController: UIBaseViewController {
    
    private let cellVM = MineFunctionCellVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func configUI() {
        self.setUpUserInfo()
        self.setUpUserMy()
        self.setUpFuction()
    }
    
    override func bindData() {
        cellVM.getDataArray().subscribe { (item) in
            self.functionTableview.reloadData()
        }.dispose()
    }
    
    func setUpFuction() {
        self.view.addSubview(functionTableview)
    }
    
    private lazy var functionTableview : UITableView = {
        var tab = UITableView(frame: CGRect.init(x: 0, y: 200, width: kScreenWidth, height: kScreenHeight), style: .plain)
        tab.register(cellType: MineFunctionCell.self)
        tab.separatorStyle = .none
        tab.delegate = self
        tab.dataSource = self
        tab.isScrollEnabled = false
        return tab
    }()
    
    
    // MARK: ----- 我的相关按钮
    func setUpUserMy() {
        
        self.view.addSubview(buttonView)
        buttonView.snp.makeConstraints { (item) in
            item.top.equalTo(userInfoView.snp_bottom).offset(10)
            item.left.right.equalTo(self.view)
            item.height.equalTo(80)
        }
        let mainMargin:CGFloat = 40
        let bound:CGFloat = 50
        let margin:CGFloat = (UIScreen.main.bounds.size.width - mainMargin*2 - bound*4)/3
        for index in 0 ..< 4 {
            let myBtn = UIButton.init(type:.custom)
            myBtn.bounds = CGRect.init(x: 0, y: 0, width: bound, height: bound)
            myBtn.tag = 100+index
            myBtn.center = CGPoint.init(x: mainMargin + CGFloat(index)*(bound+margin) + bound/2.0, y: 40)
            myBtn.backgroundColor = UIColor.red
            myBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            myBtn.titleLabel?.numberOfLines = 2
            myBtn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            myBtn.addTarget(self, action:#selector(mybtnClick(_:)), for:.touchUpInside)
            buttonView.addSubview(myBtn)
            switch index {
            case 0:
                myBtn.setTitle("我的作品", for: .normal)
            case 1:
                myBtn.setTitle("我的评论", for: .normal)
            case 2:
                myBtn.setTitle("我的赞", for: .normal)
            case 3:
                myBtn.setTitle("我的收藏", for: .normal)
            default:
                myBtn.setTitle("我的作品", for: .normal)
            }
        }
    }
    
    lazy var buttonView:UIView = {
        let view = UIView()
        return view
    }()
    
    
    @objc func mybtnClick(_ myButton:UIButton) {
        print(myButton.tag);
        switch myButton.tag {
        case 100:
            self.navigationController?.pushViewController(MineWorksViewController(), animated: true)
            break
        case 101:
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.tabBarController?.present(vc, animated: true, completion: {
            })
            break
        case 102: break
        case 103: break
            
        default:
            print("haha")
        }
    }
    
    // MARK: ----- 个人信息栏目
    func setUpUserInfo() {
        self.view.addSubview(userInfoView)
        userInfoView.addSubview(userAvatar)
        userInfoView.addSubview(userName)
        userInfoView.addSubview(userId)
        
        userInfoView.snp.makeConstraints { (item) in
            item.left.right.equalTo(self.view)
            item.top.equalTo(self.view)
            item.height.equalTo(105)
        }
        
        userAvatar.snp.makeConstraints { item in
            item.width.height.equalTo(50.0)
            item.centerY.equalTo(userInfoView.snp_top).offset(60)
            item.centerX.equalTo(userInfoView.snp_left).offset(60)
        }
        
        userName.snp.makeConstraints { item in
            item.left.equalTo(userAvatar.snp_rightMargin).offset(20);
            item.right.equalTo(userInfoView).offset(100)
            item.height.equalTo(20)
            item.top.equalTo(userAvatar)
        }
        
        userId.snp.makeConstraints { (item) in
            item.left.right.equalTo(userName)
            item.height.equalTo(20)
            item.top.equalTo(userName.snp_bottom).offset(10)
        }
    }
    
    lazy var userInfoView:UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(mineInfoTap(_:)))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    @objc func mineInfoTap(_ tap:UITapGestureRecognizer) {
        self.navigationController?.pushViewController(MineInfoEditViewController(), animated: true)
    }
    
    
    lazy var userAvatar:UIImageView = {
        let avatar = UIImageView()
        avatar.backgroundColor = UIColor.yellow
        avatar.layer.cornerRadius = 25;
        avatar.layer.masksToBounds = true
        return avatar
    }()
    
    lazy var userName:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.text = "易鸣沙雕"
        return label
    }()
    
    lazy var userId:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 1
        label.text = "是的，你说的对"
        return label
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

// MARK: ----- 代理方法

extension UIMineViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellVM.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MineFunctionCell = tableView.dequeueReusableCell(for: indexPath, cellType: MineFunctionCell.self)
        if cellVM.dataArray[indexPath.row].title.isEmpty {
            
        }else{
            let str = cellVM.dataArray[indexPath.row].title
            cell.title.text = str
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            self.navigationController?.pushViewController(SettingViewController(), animated: true)
            break
        default:
            break
        }
    }
}
