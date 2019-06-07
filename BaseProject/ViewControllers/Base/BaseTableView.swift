//
//  BaseTableView.swift
//  Bondai
//
//  Created by Rohit Makwana on 29/01/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit

//=======================================================================
// MARK:- TableView Delegate
//
// Called when tableview load 
//=======================================================================

@objc
protocol TableViewDelegate {
    
    //Required Methods
    
    func tableView(_ tableView: BaseTableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: BaseTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: BaseTableView, heightForRowAt indexPath: IndexPath) -> CGFloat

    //Optional Methods

    @objc optional func numberOfSections(_ tableView: BaseTableView) -> Int
    @objc optional func tableView(_ tableView: BaseTableView, didDeSelectRowAt indexPath: IndexPath)
    @objc optional func tableView(_ tableView: BaseTableView, didSelectRowAt indexPath: IndexPath)
    @objc optional func tableView(_ tableView: BaseTableView, viewForHeaderInSection section: Int) -> UIView

    @objc optional func startPullToRefresh(_ tableView: BaseTableView)
}

class BaseTableView: UITableView {

    
    //=======================================================================
    // MARK:- Declared Variables
    //=======================================================================

    var tableViewDelegate : TableViewDelegate? {
        
        willSet(newValue) {
            
            self.delegate           = self
            self.dataSource         = self
        }
    }

    
    var backGroundColor : UIColor?

    var cellNIBName : String = "" {
        
        willSet(newValue){
            self.register(UINib(nibName: newValue, bundle: nil), forCellReuseIdentifier: newValue)
        }
    }
    
    var attributedEmptyMessage : String = "No Data Found!" {
        willSet(newValue){
            self.designNoDataView(message: newValue)
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
                self.setUpForPullToRefresh()
            }
        }
    }
    
    var refControl : UIRefreshControl!
    private var noDataView : UIView!
    private var emptyMessaseLabel : UILabel!
    
    //=======================================================================
    // MARK:- Awake From NIB
    //=======================================================================

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initializeTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    //=======================================================================
    // MARK:- Initialize TableView
    //=======================================================================

    func initializeTableView() {
        
        self.estimatedRowHeight = 150.0
        self.rowHeight          = UITableView.automaticDimension
        self.separatorStyle     = .none
        self.estimatedSectionHeaderHeight = 0.0
        
        self.keyboardDismissMode = .interactive
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        self.designNoDataView(message: self.emptyMessage)
    }
    
    //=======================================================================
    // MARK:- Design No Post View
    //=======================================================================

    func designNoDataView(message: String) {
        
        self.layoutIfNeeded()
        
        if (self.noDataView != nil) {
            
            self.noDataView.removeFromSuperview()
            self.emptyMessaseLabel.removeFromSuperview()
            self.noDataView = UIView()
            self.emptyMessaseLabel = UILabel()
        }
        
        self.noDataView = UIView(frame: CGRect.zero)
        self.noDataView.backgroundColor = AppColor.Clear
        
        let lblFont   = Helper.setFont(WithFontFamily: Font.Montserrat_Medium, AndFontSize: 17.0)
        let lblHeight = Helper.shared.heightForLabel(text: message as String, font: lblFont, width: self.frame.width-40.0)
        
        self.noDataView.frame = CGRect(x: 20, y: (self.height - (lblHeight+20.0))/2, width: self.frame.width-40.0, height: lblHeight+20.0)
        let lblframe  = CGRect(x: 0, y: 10, width: noDataView.frame.width, height: lblHeight)
        
        self.emptyMessaseLabel = UIComponent.sharedInstance.addLabel(frame: lblframe, textAlignment: .center, text: message as String, font: lblFont, textColor: AppColor.Black, backgroundColor: AppColor.Clear)
        
        self.emptyMessaseLabel.numberOfLines = 0
        self.emptyMessaseLabel.lineBreakMode = .byWordWrapping
        
        self.noDataView.addSubview(self.emptyMessaseLabel)
        self.noDataView.isHidden = true
        self.addSubview(noDataView)
    }

    func reloadTableView() {
        self.reloadData()
    }
    
    func isHideEmptyView(_ isDisplay: Bool) {
        self.noDataView.isHidden = isDisplay
    }
    
    func updateTextAlignment(_ alignment: NSTextAlignment) {
        self.emptyMessaseLabel.textAlignment = alignment
    }
}

// MARK:-
extension BaseTableView: UITableViewDelegate, UITableViewDataSource {
    
    //=======================================================================
    // MARK:- UITableView Delegate & DataSource
    //=======================================================================

    func numberOfSections(in tableView: UITableView) -> Int {
        
        if self.tableViewDelegate != nil {
            return self.tableViewDelegate?.numberOfSections?(self) ?? 1
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.tableViewDelegate != nil {
            return self.tableViewDelegate!.tableView(self, numberOfRowsInSection: section)
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.tableViewDelegate != nil {
            return self.tableViewDelegate!.tableView(self, cellForRowAt: indexPath)
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.tableViewDelegate != nil {
            return self.tableViewDelegate!.tableView(self, heightForRowAt: indexPath)
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.tableViewDelegate != nil {
            self.tableViewDelegate?.tableView?(self, didSelectRowAt: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if self.tableViewDelegate != nil {
            self.tableViewDelegate?.tableView?(self, didDeSelectRowAt: indexPath)
        }
    }
}


// MARK:-
extension BaseTableView {
    
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
        
        print("endRefreshing called")
        if self.tableViewDelegate != nil {
            self.tableViewDelegate?.startPullToRefresh?(self)
        }
    }
    
    func endRefreshing() {
        
        if self.refControl != nil {
            self.refControl.endRefreshing()
        }
    }
}
