//
//  ListingScreenViewController.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 13/08/21.
//

import Foundation
import UIKit

class ListingScreenViewController: BaseviewController  {
    
    var listingVM = ListingViewModel()
    //MARK:IbOutlet
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBadgeCount()
    }
    
    func intializeUI() {
        self.title  =  listingVM.getTitle()
        setTableViewMethods()
        addBagButton()
        listingVM.prepareData(delegate: self)
        updateBadgeCount()
    }
    
    func setTableViewMethods() {
        self.tableView.rowHeight = listingVM.getTableViewRowHeight()
        self.tableView.estimatedSectionHeaderHeight = listingVM.getTableViewEstimatedSectionHeaderHeight()
        self.tableView.sectionHeaderHeight = listingVM.getTableViewEstimatedSectionHeaderHeight()
        self.tableView.estimatedRowHeight = listingVM.getTableViewEstimatedRowHeight()
        self.tableView.registerCell(cellName: String(describing: ProductInfoCell.self))
        self.tableView.refreshControl  = refreshControl
        self.tableView.dataSource  = self
        self.tableView.delegate  =  self
        self.tableView.separatorStyle = .none
        self.tableView.reloadData()
    }
    
    func addBagButton() {
        let bagButton = UIBarButtonItem(image: UIImage(named: "my_bag_ios")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(openCartScreen))
        bagButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.navigationItem.rightBarButtonItem = bagButton
    }
    
    @objc func openCartScreen(){
        if !(listingVM.checkForBagCountisEmpty()){
            let cartVC  = CartViewController.openCartViewController()
            self.present(UINavigationController(rootViewController: cartVC), animated: true, completion: nil)
        }
        else {
            self.showAlert(self, message: self.listingVM.getBagCountMessage())
        }
    }
    
    
    
    func updateBadgeCount() {
        self.navigationItem.rightBarButtonItem?.addBadge(number:  listingVM.getBagCount(), withOffset: CGPoint(x: -13 ,y: 0), andColor: UIColor.Theme.top_nav_text, andFilled: false)
    }
    
    override func pullToRefreshUI() {
        super.pullToRefreshUI()
    }
}
extension ListingScreenViewController : UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listingVM.getTableViewSectionCount()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listingVM.getRowCount(forSection: section)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let productInfoCell  = cell as? ProductInfoCell {
            if let product  = self.listingVM.getProductInfo(forSection: indexPath) {
                productInfoCell.loadImageFromUrl(product, randomColor: self.listingVM.getRandomColor())
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier  = listingVM.getCellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProductInfoCell,let product = listingVM.getProductInfo(forSection : indexPath) {
            cell.setData(product: product, ishideQtyButton: true, listingVM: listingVM)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 16, y: 0, width: self.view.bounds.size.width, height: 25) )
        label.attributedText = listingVM.getSectionTitle(forSection: section)
        label.backgroundColor = UIColor.white
        return label
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addAction = UIContextualAction(style: .normal, title: "Add", handler: { [weak self] (action, view, success) in
            self?.listingVM.addProductToBag(indexPath: indexPath)
            self?.updateBadgeCount()
            success(true)
            self?.showAlert(self ?? UIViewController(), message: self?.listingVM.getAlertMessage() ?? emptyString)
            //self?.showAlert(self ?? )
        })
        addAction.backgroundColor = .blue
        return UISwipeActionsConfiguration(actions: [addAction])
    }
    
    
}
extension ListingScreenViewController :  ListingViewModelDelegate {
    func getUpdatedBagCount() {
        
    }
    
    func getPriceRangeList() {
        self.tableView.reloadData()
    }
}
