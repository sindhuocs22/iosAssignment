//
//  CountryList.swift
//  ios Assignment
//
//  Created by INFOSYS on 06/03/20.
//  Copyright © 2020 INFOSYS. All rights reserved.
//

import UIKit
import SDWebImage

class CountryList: UIViewController,CountryListViewModelDelegate {

  var tableCountry = UITableView()
  var countryListViewModel = CountryListVM()
  var arrayCountryData: [Rows]?

    override func viewDidLoad() {
        super.viewDidLoad()
      self.setupDesign()
    }
  // MARK: Design Setup
  
  func setupDesign() {
    
    countryListViewModel.delegate = self
    self.createSubViews()
    self.setupConstraints()
    tableCountry.register(CountryListCell.self, forCellReuseIdentifier: "Cell") //Register the cell for tableview
    //API calls in ViewModel Class
    countryListViewModel.sendRequestToGetCountryData()
    
  }
  func createSubViews() {
    
    self.navigationItem.title = "About Canada"
    tableCountry.translatesAutoresizingMaskIntoConstraints = false
    tableCountry.estimatedRowHeight = 80
    tableCountry.separatorStyle = .none
    tableCountry.delegate = self
    tableCountry.dataSource = self
    self.view.addSubview(tableCountry)
  }
  func setupConstraints() {
    
    tableCountry.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
    tableCountry.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
    tableCountry.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    tableCountry.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    
  }
  // MARK: Custom protocols
  func reloadData(array: [Rows]?) {
    //Receiving values from viewmodel class and passing to datasource class
    self.arrayCountryData = array
    self.tableCountry.reloadData()
    
  }
  func updateNavigationTitle(title: String) {
    //after getting API response navigation title gets updated
    self.navigationItem.title = title
  }
  func showResponseError() {
    Themes.sharedInstance.showResponseErrorAlert(controller: self)
  }
  func showNetworkError() {
    Themes.sharedInstance.showNetworkErrorAlert(controller: self)
  }

}
extension CountryList:UITableViewDataSource,UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrayCountryData?.count ?? 0
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell: CountryListCell? = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CountryListCell
    cell?.selectionStyle = .none
    if cell == nil {
      cell = CountryListCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
    }
    // Below method for urwrapping nil values
    if let object = arrayCountryData?[indexPath.row] {
      let title = "\(object.title ?? "")"
      let description = "\(object.description ?? "")"
      let imageUrl = "\(object.imageHref ?? "")"
      cell?.labelTitle.text = title
      cell?.labelDescription.text = description
      cell?.imageIcon.sd_imageIndicator = SDWebImageActivityIndicator.gray
      cell?.imageIcon.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder"))
    }
    return cell!
  }
}
