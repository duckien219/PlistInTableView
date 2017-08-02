//
//  MainVC.swift
//  PlistInTableView
//
//  Created by Nguyen Kien on 8/1/17.
//  Copyright © 2017 Nguyen Kien. All rights reserved.
//

import UIKit

class MainVC: UITableViewController,ExpandableHeaderViewDelegate {
    
    var allArray = [[String: Bool]]()
    
    var arrayOfContinents = [String]()
    
    var dictOfCountry = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadPlist()
        
    }
    func loadPlist() {
        
        var path: String = ""
        path = Bundle.main.path(forResource: "CountryList", ofType: "plist")!
        let dataArray: NSArray! = NSArray(contentsOfFile: path)
        
        for i in 0 ..< dataArray.count {
            
            let dict = dataArray[i] as! NSDictionary
            
            let continent = dict.value(forKey: "Continent") as! String
            
            self.arrayOfContinents.append(continent)
            
            let countries = dict.value(forKey: "Countries") as! NSArray
            
            self.dictOfCountry.setValue(countries, forKey: continent)
            
            let dic = [continent: false]
            
            self.allArray.append(dic)
            
//            print(continent)
//            print(countries)
            
        }
        
    }
    
    // MARK: - Table view data source
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        
        //        let key_Continent = arrayOfContinents[section]
        //        print(key_Continent)
        //        let sectionAll = allArray[section]
        //        print(sectionAll)
        //        let boolean = sectionAll[key_Continent]
        //        print(boolean)
        
        allArray[section][arrayOfContinents[section]] = !allArray[section][arrayOfContinents[section]]!
        
        tableView.beginUpdates()
        let sectionTitle = arrayOfContinents[section]
        let sectionValueCountry = dictOfCountry[sectionTitle] as! NSArray
        
        for i in 0 ..< sectionValueCountry.count{
            
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
    // Phân biệt các Section
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    // bắt sự kiện khi người dùng Tap vào Section
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        
        header.customInit(title: arrayOfContinents[section], section: section, delegate: self)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if allArray[indexPath.section][arrayOfContinents[indexPath.section]] == true {
            
            return 40
            
        } else {
            return 0
            
        }
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return arrayOfContinents.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle = arrayOfContinents[section]
        let sectionObject = dictOfCountry.object(forKey: sectionTitle) as! NSArray
        
        return sectionObject.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
//        if cell == nil {
//            
//            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
//        }
        
        let sectionTitle = arrayOfContinents[indexPath.section]
        
        let countryInContinent = dictOfCountry[sectionTitle] as! NSArray
        
        let country = countryInContinent[indexPath.row] as! NSDictionary
        
        cell.textLabel?.text = country.value(forKey: "Country") as? String
        
        return cell
    }
    
    
    // Set Title cho Section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayOfContinents[section]
    }
    
    
    // Set màu cho Section và Title của Section
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    // Bắt sự kiện khi tap vào các Cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if (segue.identifier == "ShowDetail") {
            
            let detailVC = segue.destination as! DetailVC
            let selectedRowIndex: IndexPath = self.tableView.indexPathForSelectedRow!
            
            let sectionTitle = arrayOfContinents[selectedRowIndex.section]
            
            let sectionValueCountry = dictOfCountry[sectionTitle] as! NSArray
            
            let countryObject = sectionValueCountry[selectedRowIndex.row] as! NSDictionary
            
            detailVC.dictCountry = countryObject as! NSMutableDictionary
        }
        
    }
    
}


