//
//  SecondViewController.swift
//  SimpsonsAppIfe
//
//  Created by MAC Consultant on 3/4/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    //@IBOutlet weak var imageView: UIImageView!
    
    var simpsonsCol = [Simpsons.RelatedTopics]()
    var imgCollectionUrl = [String]()
    var imgCollection = [Simpsons.ImageStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let completion: (Simpsons)->() = { (simp) in
            self.simpsonsCol = simp.relatedTopics
            
//            for i in self.simpsonsCol{
//                self.imgCollectionUrl.append(i.url.url)
//            }
            let pictureCompletion: (Simpsons.ImageStruct)-> () = { (img) in
                self.imgCollection.append(img)
                
                print("here")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
                    self.collectionView.reloadData()
                })
            }
            let service = SimpsonsService()
            
            for i in self.simpsonsCol {
                service.downloadPicture(for: i, completion: pictureCompletion )
            }
            
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
//                self.collectionView.reloadData()
//           })

        }
        let service = SimpsonsService()
        service.downloadSimpsons(completion: completion)

        
        collectionView.dataSource = self
        collectionView.delegate = self
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSimpsonCol" {
            let vc = segue.destination as! detailedSimpsonsViewController
            //get the index of the selected row
            if let cell = sender as? SimpsonsCollectionViewCell {
                if let indexPath = collectionView.indexPath(for: cell) {
                    // code here to use indexPath.row and pass to viewcontroller
                    vc.image = UIImage(data: imgCollection[indexPath.row].image!)
                    vc.itext = simpsonsCol[indexPath.row].text
                }
            }
            //let index = collectionView.indexPath(for: SimpsonsCollectionViewCell)
            
        }
    }

}

extension SecondViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailSimpsonCol", sender: collectionView.cellForItem(at: indexPath))
        
        // reload collectionView
        //collectionView.reloadData()
    }
    
}

extension SecondViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // width & height
        // CG = Core Graphics
//        if let simpsonsImage = imgCollection[indexPath.row].image {
//            let image = UIImage(data: simpsonsImage)!
//
//            let size = CGSize(width: image.size.width,
//                              height: image.size.height + 30.0)
//            return size
//        }
        let width = collectionView.frame.size.width / 3.0
        let height = width + 30.0
        let size = CGSize(width: width, height: height)
        return size
    }
}

extension SecondViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgCollection.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SimpsonsCollectionViewCell
        
        let simp = imgCollection[indexPath.row]
        if let imageData = simp.image {
            let image = UIImage(data: imageData)
            cell.imageView.image = image
        }
        else {
            cell.imageView.image = nil
        }

        return cell
    }
}


