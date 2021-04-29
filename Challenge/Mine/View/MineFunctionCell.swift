//
//  MineFunctionCell.swift
//  Challenge
//
//  Created by ice on 2020/3/16.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit

class MineFunctionCell: UIBaseTableViewCell {

    public lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: kCellTitleFont)
        label.textAlignment = .left
        return label
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configUI() {
        self.addSubview(title)
    }

    override func layoutSubviews() {
        self.title.snp.makeConstraints { (item) in
            item.top.equalTo(self.snp_top).offset(10)
            item.left.equalTo(self.snp_left).offset(25)
            item.bottom.equalTo(self.snp_bottom).offset(-10)
            item.width.equalTo(100)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
