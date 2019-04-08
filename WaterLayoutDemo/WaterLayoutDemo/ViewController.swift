//
//  ViewController.swift
//  WaterLayoutDemo
//
//  Created by zsx on 2019/2/21.
//  Copyright © 2019年 zsx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var girls:[GirlModel] = [GirlModel]()
    
    
    private lazy var mainCv:UICollectionView = {
        [unowned self] in
        
        let layout = WaterFlowLayout(block: { (item) -> (CGFloat) in
            print("\(item) ----> \(self.girls[item].height)")
            return self.girls[item].height
        })
        
        let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        cv.register(GirlCollectionViewCell.self, forCellWithReuseIdentifier: GirlCollectionViewCell.identifier)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...100 {
            
            let index = i % 6
            
            var name = "girl"
            name = name.appending("\(index).jpg")
            
            let model = GirlModel()
            model.girlName = name
            model.index = i
            
            self.girls.append(model)
        }
        
        self.view.addSubview(self.mainCv)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.1) {
            self.mainCv.setContentOffset(CGPoint(x: 0, y: 0.5), animated: false)
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.girls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:GirlCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: GirlCollectionViewCell.identifier, for: indexPath) as? GirlCollectionViewCell)!
        
        cell.setData(girlModel: self.girls[indexPath.item])
        cell.reloadBlock = {
            [unowned self] in
            self.mainCv.reloadData()
        }
        return cell
    }
    
    
}

