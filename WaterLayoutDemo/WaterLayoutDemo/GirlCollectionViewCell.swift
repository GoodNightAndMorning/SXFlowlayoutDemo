//
//  GirlCollectionViewCell.swift
//  WaterLayoutDemo
//
//  Created by zsx on 2019/2/21.
//  Copyright © 2019年 zsx. All rights reserved.
//

import UIKit

class GirlCollectionViewCell: UICollectionViewCell {
    var reloadBlock:(() -> ())?
    
    static let identifier = "GirlCollectionViewCell"
    
    private lazy var girlIcon:UIImageView = {
        [unowned self] in
        let image = UIImageView(frame: self.bounds)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(self.girlIcon)
        
        let left = NSLayoutConstraint(item: self.girlIcon, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: self.girlIcon, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: self.girlIcon, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: self.girlIcon, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        
        self.addConstraints([left, right, top, bottom])
    }
    
    public func setData(girlModel:GirlModel) {
        self.girlIcon.image = UIImage(named: girlModel.girlName)
        
        if !girlModel.isLoad {
            
            if let width = self.girlIcon.image?.size.width,
                let height = self.girlIcon.image?.size.height {
                
                girlModel.setHeight(h: height / width * UIScreen.main.bounds.size.width / 2)
            }
        }
    }
}
