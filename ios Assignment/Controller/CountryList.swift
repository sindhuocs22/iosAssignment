//
//  CountryList.swift
//  ios Assignment
//
//  Created by INFOSYS on 06/03/20.
//  Copyright © 2020 INFOSYS. All rights reserved.
//

import UIKit

class CountryList: UIViewController {

  var tableCountry = UITableView()
  var arrayCountryData: [Rows]?

    override func viewDidLoad() {
        super.viewDidLoad()
      self.setupDesign()
    }
  // MARK: Design Setup
  
  func setupDesign() {
    
    self.createSubViews()
    self.setupConstraints()
    tableCountry.register(CountryListCell.self, forCellReuseIdentifier: "Cell") //Register the cell for tableview
    
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
  

}
extension CountryList:UITableViewDataSource,UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return 10
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell: CountryListCell? = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CountryListCell
    cell?.selectionStyle = .none
    if cell == nil {
      cell = CountryListCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
    }
    cell?.labelTitle.text = "title"
    cell?.labelDescription.text = "Description"
    return cell!
  }
}
