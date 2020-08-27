//
//  LandingVC.swift
//  AxxessTechPOC
//
//  Created by Rajesh Deshmukh on 25/08/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import UIKit
import  SnapKit

class LandingVC: UIViewController {
    
    /// Private Constants
    
    private struct Constant {
        static let estimatedRowHeight: CGFloat = 44
    }
    
    /// Variables
    
    var tableView: UITableView?
    lazy var viewModelObj = FactsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = viewModelObj.getNavTitle()
        configureTableView()
        
        if InternetConnectionManager.isConnectedToNetwork() {
            APICall()
        } else {
            offlineMode()
        }
    }
}


// MARK: - TableView Utility Methods

extension LandingVC {
    
    /// Function to configure TableView
    
    func configureTableView() {
        tableView = UITableView()
        self.view.addSubview(tableView ?? UITableView())
       
        tableView?.snp.makeConstraints({ make in
            make.edges.equalTo(self.view)
        })
        
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = LandingVC.Constant.estimatedRowHeight
        registerTableCell()
        
        ///Eliminate extra separators below UITableView
        tableView?.tableFooterView = UIView()
        
    }
    
    /// Function to  register table view cell
    
    func registerTableCell () {
        if let tableView = tableView {
            tableView.register(FactsTableViewCell.self, forCellReuseIdentifier: AppConstants.CellIdentifire.kFactsTableViewCellId)
        }
    }
    
    /// Function to creation cell  and it's configuration
    /// - parameter indexPath: IndexPath for cell
    /// - ReturnS: instance of ImageTableViewCell
    
    func getFactsTableViewCellFor(indexPath: IndexPath) -> FactsTableViewCell? {
        let cell = tableView?.dequeueReusableCell(withIdentifier: AppConstants.CellIdentifire.kFactsTableViewCellId, for: indexPath) as! FactsTableViewCell
        
        /// set table view cell data
        cell.rowCellModel = viewModelObj.getPerticularFactAtIndexPath(indexPath: indexPath)
        return cell
    }
    
}


// MARK: -  TableView Data Source

extension LandingVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModelObj.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelObj.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getFactsTableViewCellFor(indexPath: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailobj = DetailVC()
        detailobj.modelDataObj = viewModelObj.getPerticularFactAtIndexPath(indexPath: indexPath)
        self.navigationController?.pushViewController(detailobj, animated: true)
    }
    
}

// MARK: - API Utility Methods

extension LandingVC {
    
    /// Function to fetch API Data
    
    func APICall() {
        
        viewModelObj.fetchFacts(resultType: [FactsModel].self) { result in
            switch(result) {
            case .success(let result):
               
                if result.count > 0 {
                    DispatchQueue.main.async {
                         self.tableView?.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                         self.noRecordsAlertShow()
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: AppConstants.LiteralString.errorTitle,
                                   message : error.localizedDescription,
                                   actionTitle : AppConstants.LiteralString.okBtn)
                }
                
            }
        }
        
    }
    
    /// Function to fetch Data from DB
    
    func offlineMode() {
        
        viewModelObj.fetchDataForOfflineMode()
        if viewModelObj.respoceObj?.count ?? 0 > 0 {
            self.tableView?.reloadData()
        } else {
            noRecordsAlertShow()
            
        }
        
    }
    
    func noRecordsAlertShow() {
        self.showAlert(title: AppConstants.LiteralString.errorTitle,
                       message : AppConstants.LiteralString.noRecordsErrorMsg,
                       actionTitle : AppConstants.LiteralString.okBtn)
    }
    
}
