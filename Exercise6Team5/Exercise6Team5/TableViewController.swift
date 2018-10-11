//
//  TableViewController.swift
//  Exercise6Team5
//
//  Created by ubicomp5 on 10/11/18.
//  Copyright © 2018 cpl.ubicomp. All rights reserved.
//

import UIKit
import MapKit

struct Locations: Codable {
    let company: String
    let hq_latitude: Double
    let hq_longitude: Double
    
    init() {
        company = ""
        hq_latitude = 0
        hq_longitude = 0
    }
}

class TableViewController: UITableViewController {
    
    var locations = [Locations]()
    
    var selectedLocation = Locations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Locations"
        let url = URL(string: "http://cpl.uh.edu/courses/ubicomp/fall2018/webservice/companies.json")
        if url != nil {
            getData(url: url!)
        }
    }
    
    func getData(url: URL) {

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let locations = try jsonDecoder.decode(Array<Locations>.self, from: data)
                    print(locations)
                    self.locations = locations
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error trying to decode JSON object")
                }
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let name = cell.viewWithTag(1) as! UILabel
        
        name.text = locations[indexPath.row].company
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLocation = locations[indexPath.row]
        self.performSegue(withIdentifier: "detailedSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailedSegue" {
            let dvc = segue.destination as! ViewController
            dvc.location = selectedLocation
        }
    }
}
