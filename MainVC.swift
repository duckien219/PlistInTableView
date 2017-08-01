//
//  MainVC.swift
//  PlistInTableView
//
//  Created by Nguyen Kien on 8/1/17.
//  Copyright © 2017 Nguyen Kien. All rights reserved.
//

import UIKit

class MainVC: UITableViewController {
    
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
            
            print(continent)
            print(countries)
            
        }
        print(arrayOfContinents.count)

    }
   
    // MARK: - Table view data source

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
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        }
        
        let sectionTitle = arrayOfContinents[indexPath.section]
        
        let countryInContinent = dictOfCountry[sectionTitle] as! NSArray
        
        let country = countryInContinent[indexPath.row] as! NSDictionary

        cell.textLabel?.text = country.value(forKey: "Country") as! String
        

        // Configure the cell...

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "ShowDetail") {
            
            let detailVC = segue.destination as! DetailVC
            let selectedRowIndex: IndexPath = self.tableView.indexPathForSelectedRow!
            
            let sectionTitle = arrayOfContinents[selectedRowIndex.section]
            
            let sectionValueCountry = dictOfCountry[sectionTitle] as! NSArray
            
            let countryObject = sectionValueCountry[selectedRowIndex.row] as! NSDictionary
            
            detailVC.dictCountry = countryObject as! NSMutableDictionary
        }
        
            
            
            
            
            
        }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

   
    
        
        
        
        
    }
   

