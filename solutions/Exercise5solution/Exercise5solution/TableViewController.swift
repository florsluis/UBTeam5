//
//  TableViewController.swift
//  Exercise5solution
//
//  Created by Emtiaz Ahmed on 10/3/18.
//  Copyright © 2018 Emtiaz Ahmed. All rights reserved.
//

import UIKit

struct Languages: Codable {
    init() {
        name = ""
        designed_by = ""
        logo = URL(string: "http://www.google.com")!
        first_appeared = 0
        website = ""
        about = ""
        
    }
    let name: String
    let designed_by: String
    let logo: URL
    let first_appeared: Int
    let website: String
    let about: String
   
   
}

class TableViewController: UITableViewController {
    
    var language = [Languages]()
    var selectedLanguage = Languages()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Languages"
        
        let url = URL(string: "http://cpl.uh.edu/courses/ubicomp/fall2018/webservice/languages.json")
        if url != nil {
            getData(url: url!)
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return language.count
    }
    
    func getData(url: URL) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonDecoder = JSONDecoder()
                    let languages = try jsonDecoder.decode(Array<Languages>.self, from: data)
                    print(languages)
                    self.language = languages
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
    
  

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let logo = cell.viewWithTag(1) as! UIImageView
        let name = cell.viewWithTag(2) as! UILabel
        let firstAppeared = cell.viewWithTag(3) as! UILabel
        
        
        
        name.text = language[indexPath.row].name
        firstAppeared.text = "Est. \(language[indexPath.row].first_appeared)"
        
        let url = language[indexPath.row].logo
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                logo.image = UIImage(data: data!)
            }
        }).resume()
        
    

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLanguage = language[indexPath.row]
        self.performSegue(withIdentifier: "segueToDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToDetails" {
            let dvc = segue.destination as! ViewController
            dvc.language = selectedLanguage
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
