//
//  BaseCollectionView.swift
//  Bondai
//
//  Created by Rohit Makwana on 30/01/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit

//=======================================================================
// MARK:- IGCollectionViewDelegate
//
// Called when CollectionView load
//=======================================================================

@objc
protocol CollectionViewDelegate {
    
    //Required Methods
    
    func numberOfSections(_ collectionView: BaseCollectionView) -> Int
    func collectionView(_ collectionView: BaseCollectionView, numberOfRowsInSection section: Int) -> Int
    func collectionView(_ collectionView: BaseCollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func collectionView(_ collectionView: BaseCollectionView, didSelectItemAt indexPath: IndexPath)

    //Optional Methods
    
    @objc optional func collectionView(_ collectionView: BaseCollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    @objc optional func collectionView(_ collectionView: BaseCollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    @objc optional func collectionView(_ collectionView: BaseCollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    
    @objc optional func startPullToRefresh(_ collectionView: BaseCollectionView)
}


class BaseCollectionView: UICollectionView {

    var collectionViewDelegate : CollectionViewDelegate? {
        
        willSet(newValue) {
            
            self.delegate           = self
            self.dataSource         = self
        }
    }

    var cellNIBName : String = "" {
        
        willSet(newValue){
            self.register(UINib(nibName: newValue, bundle: nil), forCellWithReuseIdentifier: newValue)
        }
    }
    
    var emptyMessage : String = "No Data Found!" {
        willSet(newValue){
            self.designNoDataView(message: newValue)
        }
    }
    
    var isRefreshControl : Bool = false {
        
        willSet(newValue){
            
            if newValue == true {
//                self.setUpForPullToRefresh()
            }
        }
    }
    
    private var refControl : UIRefreshControl!
    private var noDataView : UIView!
    private var emptyMessaseLabel : UILabel!

    // MARK:- ========================= CollectionView LifeCycle =========================
    
    
    //=======================================================================
    // MARK:- Awake From NIB
    //=======================================================================

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initializeCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    //=======================================================================
    // MARK:- Initialize CollectionView
    //=======================================================================

    func initializeCollectionView() {
        
        self.backgroundColor = AppColor.Clear
        
        self.keyboardDismissMode = .interactive
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        self.bounces = true
        self.designNoDataView(message: self.emptyMessage)
    }
    
    //=======================================================================
    // MARK:- Design No Post View
    //=======================================================================

    func designNoDataView(message: String) {
        
        if (self.noDataView != nil) {
            
            self.noDataView.removeFromSuperview()
            self.emptyMessaseLabel.removeFromSuperview()
            self.noDataView        = UIView()
            self.emptyMessaseLabel = UILabel()
        }
        
        self.noDataView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH*0.89, height: 100.0))
        self.noDataView.backgroundColor = AppColor.Clear
        
        let lblFont   = Helper.setFont(WithFontFamily: Font.Montserrat_Medium, AndFontSize: 17.0)
        let lblHeight = Helper.shared.heightForLabel(text: message as String, font: lblFont, width: noDataView.frame.width)
        let lblframe  = CGRect(x: 0, y: 0, width: noDataView.frame.width, height: lblHeight)
        
        self.emptyMessaseLabel = UIComponent.sharedInstance.addLabel(frame: lblframe, textAlignment: .center, text: message as String, font: lblFont, textColor: AppColor.Black, backgroundColor: AppColor.Clear)
        
        self.emptyMessaseLabel.numberOfLines = 0
        self.emptyMessaseLabel.lineBreakMode = .byWordWrapping
        
        self.noDataView.addSubview(self.emptyMessaseLabel)
        self.noDataView.isHidden = true
        self.addSubview(noDataView)
        self.noDataView.center = CGPoint(x: self.width/2, y: self.height/2-20)
    }
    
    func reloadCollection() {
        
        self.reloadData()
    }
    
    func isHideEmptyView(_ isDisplay: Bool) {
        
        self.noDataView.isHidden = isDisplay
    }

}

// MARK:-
extension BaseCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    //=======================================================================
    // MARK:- UICollection Delegate & DataSource and FlowLayout
    //=======================================================================
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if self.collectionViewDelegate != nil {
            return self.collectionViewDelegate?.numberOfSections(self) ?? 1
        }
        
        return 1
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.collectionViewDelegate != nil {
           return self.collectionViewDelegate!.collectionView(self, numberOfRowsInSection: section)
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.collectionViewDelegate != nil {
            return self.collectionViewDelegate!.collectionView(self, cellForItemAt: indexPath)
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.collectionViewDelegate != nil {
            self.collectionViewDelegate?.collectionView(self, didSelectItemAt: indexPath)
        }
    }
}

// MARK:-
extension BaseCollectionView {
    
    //=======================================================================
    // MARK:- Pull To Refresh
    //=======================================================================
    
    //Setup for headerView Refresh
    func setUpForPullToRefresh() {
        
        if self.refControl == nil {
            
            self.refControl = UIRefreshControl()
            self.refControl.addTarget(self, action: #selector(self.pullToRefresh), for: .valueChanged)
            self.addSubview(self.refControl)
        }
    }
    
    //Selector Method
    @objc func pullToRefresh() {
        
        if self.collectionViewDelegate != nil {
            
            self.endRefreshing()
            self.collectionViewDelegate?.startPullToRefresh?(self)
        }
    }
    
    func endRefreshing() {
        
        if self.refControl != nil {
            
            self.layoutIfNeeded()
            self.refControl.endRefreshing()
        }
    }
}
