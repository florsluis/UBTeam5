//
//  FilterTableViewController.swift
//  Exercise7_solution
//
//  Created by Emtiaz Ahmed on 10/16/18.
//  Copyright © 2018 Emtiaz Ahmed. All rights reserved.
//

import UIKit
import CoreImage

class FilterTableViewController: UITableViewController {
    
    var arrayOfImage: [UIImage] = []
    var filterNames = ["Black&White", "Sepia", "Noir"]
    
    var context = CIContext()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(arrayOfImage.count)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let openGlCtx = EAGLContext(api: .openGLES2){
            context = CIContext(eaglContext: openGlCtx)
        }
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
        return arrayOfImage.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let imgview = cell.viewWithTag(1) as! UIImageView
        
        let lblFilter = cell.viewWithTag(3) as! UILabel
        let btnSave = cell.viewWithTag(2) as! UIButton
        
        
        lblFilter.text = filterNames[indexPath.row]
        
        if (lblFilter.text == "Black&White"){
            imgview.image = convertToBlack(image: arrayOfImage[indexPath.row])

        }
        else if (lblFilter.text == "Sepia"){
            imgview.image = convertToSepia(image: arrayOfImage[indexPath.row], context: context)

        }
        else if (lblFilter.text == "Noir"){
            imgview.image = convertToNoir(image: arrayOfImage[indexPath.row], context: context)

        }
        
        btnSave.tag = indexPath.row

        btnSave.addTarget(self, action: #selector(self.saveImage(sender:)), for: .touchUpInside)

        return cell
    }
    
    @objc func saveImage(sender: UIButton){
        
        
        if (sender.tag == 0){
            let image = convertToBlack(image: arrayOfImage[0])
            let imageData = UIImagePNGRepresentation(image)
            let compressedImage = image
            UIImageWriteToSavedPhotosAlbum(compressedImage, nil, nil, nil)

            
        }
        if (sender.tag == 1){
            let image = convertToSepia(image: arrayOfImage[1], context: context)
            let imageData = UIImagePNGRepresentation(image)
            let compressedImage = UIImage(data: imageData!)
            UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
            
            
        }
        if (sender.tag == 2){
            let image = convertToNoir(image: arrayOfImage[2], context: context)
            let imageData = UIImagePNGRepresentation(image)
            let compressedImage = UIImage(data: imageData!)
            UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
            
            
        }
        let alert = UIAlertController(title: "Saved", message: "Image Saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    func convertToBlack(image: UIImage) -> UIImage {
        
        let bwImage = CIImage(image: image)
        let convertedImage = bwImage?.applyingFilter("CIColorControls", parameters: [kCIInputSaturationKey: 0.0])
        return UIImage(ciImage: convertedImage!)
    }
    
    func convertToNoir(image: UIImage, context: CIContext) -> UIImage {
        let inputCIImage = CIImage(image: image)
        let filter = CIFilter(name: "CIPhotoEffectNoir")!
        filter.setValue(inputCIImage, forKey: kCIInputImageKey)
        let ciImage = filter.outputImage
        
       
        let cgImage = context.createCGImage(ciImage!, from: (ciImage?.extent)!)

        return UIImage(cgImage: cgImage!)
       
        
    }
    
    func convertToSepia(image: UIImage, context: CIContext) -> UIImage {
        let inputCIImage = CIImage(image: image)
        let filter = CIFilter(name: "CISepiaTone")!
        filter.setValue(inputCIImage, forKey: kCIInputImageKey)
        let ciImage = filter.outputImage
        
        
        let cgImage = context.createCGImage(ciImage!, from: (ciImage?.extent)!)
        
        return UIImage(cgImage: cgImage!)
        
        
    }
    

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
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
