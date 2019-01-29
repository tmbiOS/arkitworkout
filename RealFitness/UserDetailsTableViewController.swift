//
//  UserDetailsTableViewController.swift
//  RealFitness
//
//  Created by Andrey Rudenko on 29/01/2019.
//  Copyright © 2019 Satori Worldwide, Inc. All rights reserved.
//

import UIKit

class UserDetailsTableViewController: UITableViewController {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var phoneLabel: UITableViewCell!
  @IBOutlet weak var facebookLabel: UILabel!

  @IBOutlet weak var twitterLabel: UILabel!

  @IBOutlet weak var linkedinLabel: UILabel!


  override func viewDidLoad() {
    tableView.tableFooterView = UIView()
  }

}
