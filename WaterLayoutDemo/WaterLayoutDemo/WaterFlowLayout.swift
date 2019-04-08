//
//  WaterFlowLayout.swift
//  WaterLayoutDemo
//
//  Created by zsx on 2019/2/21.
//  Copyright © 2019年 zsx. All rights reserved.
//

import UIKit

class WaterFlowLayout: UICollectionViewFlowLayout {

    private var heightBlock:((_ item:Int) -> (CGFloat))?
    
    private var heightArr:[CGFloat]?
    
    private let colCount = 2
    
    private func getHeightArr() -> [CGFloat] {
        if heightArr == nil {
            heightArr = [CGFloat]()
            for _ in 0..<colCount {
                heightArr?.append(0)
            }
        }
        return heightArr!
    }
    
    private var widht:CGFloat = 0
    
    init(block:@escaping (_ item:Int) -> (CGFloat)) {
        
        self.heightBlock = block
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension WaterFlowLayout {
    override func prepare() {
        super.prepare()
        
        self.widht = UIScreen.main.bounds.size.width / 2
        
        self.heightArr = nil
    }
    
    override var collectionViewContentSize: CGSize {
        get {
            var maxH:CGFloat = 0
            for colH in getHeightArr() {
                if colH > maxH {
                    maxH = colH
                }
            }
            return CGSize(width: (collectionView?.bounds.width)!, height: maxH)
        }
        set {
            self.collectionViewContentSize = newValue
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        var maxHeigtCol:Int = 0
        var maxHeight:CGFloat = getHeightArr()[0]
        
        for (index,h) in getHeightArr().enumerated() {
            if h < maxHeight {
                maxHeight = h
                maxHeigtCol = index
            }
        }
        
        let x:CGFloat = self.widht * CGFloat(maxHeigtCol);
        let y:CGFloat = maxHeight
        var h:CGFloat = 0
        if let block = self.heightBlock {
            h = block(indexPath.item)
        }
        
        attr.frame = CGRect(x: x, y: y, width: self.widht, height: h)
        
        self.heightArr![maxHeigtCol] = maxHeight + h
        
        return attr
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var arr = [UICollectionViewLayoutAttributes]()
        
        let items:Int = (self.collectionView?.numberOfItems(inSection: 0))!
        
        for i in 0..<items {
            let attr:UICollectionViewLayoutAttributes = self.layoutAttributesForItem(at: IndexPath(item: i, section: 0))!
            
            arr.append(attr)
        }
        return arr
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
