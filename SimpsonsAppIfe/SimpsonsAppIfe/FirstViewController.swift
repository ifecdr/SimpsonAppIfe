//
//  FirstViewController.swift
//  SimpsonsAppIfe
//
//  Created by MAC Consultant on 3/4/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var simpsonsCol = [Simpsons.RelatedTopics]()
    var imgCollectionUrl = [String]()
    var imgCollection = [Simpsons.ImageStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let completion: (Simpsons)->() = { (simp) in
            self.simpsonsCol = simp.relatedTopics
            
            let pictureCompletion: (Simpsons.ImageStruct)-> () = { (img) in
                self.imgCollection.append(img)
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
                    self.tableView.reloadData()
                })
            }
            let service = SimpsonsService()
            
            for i in self.simpsonsCol {
                service.downloadPicture(for: i, completion: pictureCompletion )
            }
        }
        let service = SimpsonsService()
        service.downloadSimpsons(completion: completion)
        
        //print(simpsonsCol)
        //self.view.subviews(tableView)
        //let nib = UINib(nibName: "SimpsonsTableViewCell", bundle: nil)
        //tableView.register(nib, forCellReuseIdentifier: "SimpsonsTableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSimpsons" {
            let vc = segue.destination as! detailedSimpsonsViewController
            //get the index of the selected row
            let index = tableView.indexPathForSelectedRow?.row
            vc.image = UIImage(data: imgCollection[index!].image!)
            vc.itext = simpsonsCol[index!].text
        }
    }

//    override func prepare(segue: UIStoryboardSegue, sender: AnyObject!) {
//
//    }

}

extension FirstViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailSimpsons", sender: self)
        
    }

    
}

extension FirstViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return simpsonsCol.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // customize my cell
        let simp = simpsonsCol[indexPath.row]
        cell.textLabel!.text = simp.text

        // return cell
        return cell
    }
    

    
}
