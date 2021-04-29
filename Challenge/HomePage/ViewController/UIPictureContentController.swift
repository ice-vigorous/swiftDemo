//
//  UIPictureContentController.swift
//  Challenge
//
//  Created by ice on 2020/3/19.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import RxSwift

class UIPictureContentController: UIBaseViewController {
    
    var productModel: ProductsModel?
    
    let viewModel = DetailsViewModel()
    let disposeBag = DisposeBag()
    
    lazy var listView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.register(cellType: UICommentTableViewCell.self)
        tableView.register(cellType: UIPictureContentCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = 300
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension UIPictureContentController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UIPictureContentCell.self)
        return cell
    }
    
    
}
