//
//  AppDetailsViewController.swift
//  AppStoreExample
//
//  Created by Francisco Valbuena on 1/6/17.
//  Copyright © 2017 Francisco Valbuena. All rights reserved.
//

import Foundation
import UIKit

class AppInfoCell: UITableViewCell {
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
}

class AppDetailsViewController: UITableViewController {
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var informationTableView: UITableView!
    
    var viewModel: AppDetailsViewModel! {
        didSet { configureUI() }
    }
    lazy var infoDataSource: UITableViewDataSource = {
        return AppInfoDatasource(info: self.viewModel.additionalInformation)
    }()
    
    override func viewDidLoad() {
        self.navigationItem.title = "App Details"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                                 target: self,
                                                                 action: #selector(AppDetailsViewController.onDismiss))
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func configureUI() {
        guard let viewModel = self.viewModel else {
            return
        }
        appNameLabel?.text = viewModel.name
        summaryLabel?.text = viewModel.summary
        informationTableView?.dataSource = infoDataSource
        informationTableView?.rowHeight = UITableViewAutomaticDimension
        bannerImageView?.layer.cornerRadius = 10.0
        bannerImageView?.layer.masksToBounds = true
        bannerImageView?.image = viewModel.banner
        viewModel.onBannerLoaded = { [weak self, weak viewModel] in
            self?.bannerImageView.image = viewModel?.banner
        }
        self.tableView.setNeedsLayout()
    }
    
    @objc func onDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

class AppInfoDatasource: NSObject, UITableViewDataSource {
    static let cellID = "InfoCellID"
    
    let info: [(type: String, value: String)]
    
    init(info: [(type: String, value: String)]) {
        self.info = info
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellInfo = info[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: self).cellID) as! AppInfoCell
        
        cell.typeLabel.text = cellInfo.type
        cell.valueLabel.text = cellInfo.value
        cell.setNeedsLayout()
        return cell
    }
}
