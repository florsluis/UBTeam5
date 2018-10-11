//
//  TableViewController.swift
//  Exercise5Team5
//
//  Created by ubicomp5 on 10/4/18.
//  Copyright © 2018 cpl.ubicomp. All rights reserved.
//

import UIKit

struct LanguageInfo: Codable {
    let name: String
    let designed_by: String
    let logo: String
    let first_appeared: Int
    let website: String
    let about: String
    init() {
        self.name = ""
        self.designed_by = ""
        self.logo = ""
        self.first_appeared = 0
        self.website = ""
        self.about = ""
    }
}

class TableViewController: UITableViewController {
    
    var myInfo = [LanguageInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL (string: "http://www.cpl.uh.edu/courses/ubicomp/fall2018/webservice/languages.json")
        getData(url: url!)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       _ = (sender as! NSIndexPath).row
        if segue.destination is ViewController
        {
            //destinationViewController.label = data
        }
    }
    
    func getData(url: URL) {
        
        let task  = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let data = data {
                do {
                    let jsonData = JSONDecoder()
                    let datas = try! jsonData.decode(Array<LanguageInfo>.self, from: data)
                    self.myInfo = datas
                    print(self.myInfo)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("error")
                }
            } else if let error = error {
                print("Another error")
            }
        }
        task.resume()
    }
    
    override func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myInfo.count
    }
    
    override func tableView( _ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let name = cell.viewWithTag(1) as! UILabel
        let date = cell.viewWithTag(2) as! UILabel
        
        name.text = myInfo[indexPath.row].name
        date.text = String(myInfo[indexPath.row].first_appeared)
        
        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
