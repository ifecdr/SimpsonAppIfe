//
//  detailedSimpsonsViewController.swift
//  SimpsonsAppIfe
//
//  Created by MAC Consultant on 3/6/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import UIKit

class detailedSimpsonsViewController: UIViewController {
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var image: UIImage!
    var itext: String!
    var usePhotos: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if usePhotos == false {
            self.detailImage.image = image
            self.detailLabel.text = itext
        }
//        else {
//            self.imageView.image = UIImage(named: "userPhotoPlaceholder")
//            self.button.setTitle("Select Photo", for: .normal)
//        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
