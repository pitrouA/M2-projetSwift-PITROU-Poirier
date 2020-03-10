//
//  FirstViewController.swift
//  liste
//
//  Created by tp on 12/02/2020.
//  Copyright © 2020 tp. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    
    var dataJS = JSON()
    
    var data = ["fff","yyy","uuu","dhdfjgfhjfghjfghj"]
    let url = URL(string:"http://eddbali.net/files/iOS/Documents/monuments.json")
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellule = tableview.dequeueReusableCell(withIdentifier:"uneCellule", for: indexPath)
        
        cellule.textLabel?.text = data[indexPath.row]
        
        return cellule
    }
    
    private func LesTitres(_ data : JSON) -> [String]{
        var titres = [String]()
        
        for elt in data["categories"].arrayValue{
            titres.append(elt["titre"].stringValue)
        }
        
        return titres;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //tableview.delegate = self
        tableview.dataSource = self
        
        /*Alamofire.request(url!, method: .get).responseJSON{
            response in
            if(response.result.isSuccess){
                let content : JSON =  JSON(response.result.value!)
                print(content)
                self.dataJS = content
                self.data = self.LesTitres(self.dataJS)
                self.tableview.reloadData()
            }else{
                print("Error : \(response.result.error!)")
            }
        }*/
    }


}

