//
//  DetailVC.swift
//  PlistInTableView
//
//  Created by Nguyen Kien on 8/1/17.
//  Copyright © 2017 Nguyen Kien. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var imgFlag: UIImageView!
    
    @IBOutlet weak var lblCapitalCity: UILabel!
    
    
    var dictCountry = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Đặt Title cho NavigationBar
        let country = dictCountry.value(forKey: "Country") as! String?
        self.navigationItem.title = country

        let capitalCity = dictCountry.value(forKey: "Capital") as! String?
        self.lblCapitalCity.text = capitalCity
        
        let flag = dictCountry.value(forKey: "Flag") as! String?
        self.imgFlag.image = UIImage(named: flag!)
        
    }
}
