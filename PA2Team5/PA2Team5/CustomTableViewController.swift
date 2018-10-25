//  CustomTableViewController.swift
//  PA2Team5
//
//  Created by Luis Flores on 10/25/18.
//  Copyright © 2018 cpl.ubicomp. All rights reserved.

struct Contact: Codable {
    let about: String
    let phone: String
    let logo: URL
    let email: String
    let company: String
    let name: String
    let age: Int
    let _id: String
    let hq_latitude: Double
    let hq_longitude: Double
    
    init() {
        about = ""
        phone = ""
        logo = URL(string: "http://www.google.com")!
        email = ""
        company = ""
        name = ""
        age = 0
        _id = ""
        hq_latitude = 0.0
        hq_longitude = 0.0
    }
}

import UIKit

class CustomTableViewController: UITableViewController {

    var contacts = [Contact]()
    var selectedContact = Contact()
    var LogoImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contact Information"
        
        let url = URL(string: "http://cpl.uh.edu/courses/ubicomp/fall2018/webservice/contact_list.json")
        if url != nil {
            getData(url: url!)
        }
    }
    
    func getData(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let contactsData = try JSONDecoder().decode(Array<Contact>.self, from: data)
                    print(contactsData)
                    self.contacts = contactsData
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
        let name = cell.viewWithTag(1) as! UILabel
        let company = cell.viewWithTag(2) as! UILabel
        let logo = cell.viewWithTag(3) as! UIImageView

        name.text = contacts[indexPath.row].name
        company.text = contacts[indexPath.row].company
        
        let url = contacts[indexPath.row].logo
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedContact = contacts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let logo = cell.viewWithTag(3) as! UIImageView
        LogoImage = logo.image
        self.performSegue(withIdentifier: "listToDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listToDetails" {
            let destinationVC = segue.destination as! ViewController
            destinationVC.contactData = selectedContact
            destinationVC.LogoImage = LogoImage
        }
    }
}
