//
//  UIHPHotActivityCell.swift
//  Challenge
//
//  Created by ice on 2020/3/14.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit

class UIHPHotActivityCell: UIBaseTableViewCell {
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.text = "热门活动"
        titleLabel.backgroundColor = .gray
        return titleLabel
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize.width = 50
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(cellType: UIHotActivityCollectionCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    var dataSource = [ActivityModel]()
    
    
    override func configUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.height.equalTo(20)
            $0.width.equalTo(70)
            $0.centerY.equalToSuperview()
        }
        collectionView.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.right).offset(10)
            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
            $0.bottom.right.equalToSuperview().offset(-10)
        }
    }
    
    func setModelArray(_ array: [ActivityModel]) {
        dataSource = array
        collectionView.reloadData()
    }
}

extension UIHPHotActivityCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UIHotActivityCollectionCell.self)
        cell.backgroundColor = .gray
        return cell
    }
    
    
}

