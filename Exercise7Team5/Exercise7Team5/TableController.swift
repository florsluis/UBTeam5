//
//  TableController.swift
//  Exercise7Team5
//
//  Created by ubicomp5 on 10/18/18.
//  Copyright © 2018 cpl.ubicomp. All rights reserved.
//

import UIKit

class TableController: UITableViewController {
    
    var originalImage: UIImage!
    
    var images = [UIImage]()
//    let filterTypes = ["Black & White", "Sepia", "Noir"]
    let filterTypes = ["Black & White"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Before appending")
        images.append(convertToBlack(image: originalImage))
//        images.append(convertToSepia(image: originalImage))
//        images.append(convertToNoir(image: originalImage))
        print("After")
        print(images.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterTypes.count
    }
    
    func  convertToBlack(image:UIImage) -> UIImage{
        let ciBlackImage = CIImage(image: image)
        let blackImage = ciBlackImage?.applyingFilter("CIColorControls", parameters:[kCIInputSaturationKey:0.0])
        if blackImage != nil {
            print("Not nil")
        }
        return UIImage(ciImage: blackImage!)
    }
    
    func  convertToSepia(image:UIImage) -> UIImage{
        let sepiaFilter = CIFilter(name : "CISepiaTone")
        sepiaFilter?.setValue(image, forKey : kCIInputImageKey)
        sepiaFilter?.setValue(1, forKey : kCIInputIntensityKey)
        let sepiaOutput = sepiaFilter?.outputImage
        return UIImage(ciImage : sepiaOutput!)
    }
    
    func  convertToNoir(image:UIImage) -> UIImage{
        let noirFilter = CIFilter(name : "CIPhotoEffectNoir")
        noirFilter?.setValue(image, forKey : kCIInputImageKey)
        noirFilter?.setValue(1, forKey : kCIInputIntensityKey)
        let noirOutput = noirFilter?.outputImage
        return UIImage(ciImage : noirOutput!)
    }
    
    //    func saveImageButton() {
    //        let imageData = UIImagePNGRepresentation(self.image.image!)
    //        let compressedImage = UIImage(data : imageData)
    //        UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
    //        let alert = UIAlertController(title : "Saved", message : "Your image saved", preferredStyle .alert)
    //        let okAction = UIAlertAction(title : "OK", style : .default, handler)
    //        self.present(alert, animated : true, completion : nil)
    //    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let imageContainer = cell.viewWithTag(1) as! UIImageView
        let filterLabel = cell.viewWithTag(2) as! UILabel
        
        print(images.count)
        
        filterLabel.text = filterTypes[indexPath.row]

        
        imageContainer.image = images[indexPath.row]
        return cell
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
