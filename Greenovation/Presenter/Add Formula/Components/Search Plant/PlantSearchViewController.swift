//
//  PlantSearchViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 07/11/23.
//

import UIKit

class PlantSearchViewController: UIViewController {
    
    @IBOutlet var plantSearchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plantSearchTableView.dataSource = self
        plantSearchTableView.delegate = self
        plantSearchTableView.register(
            UINib(nibName: "PlantSearchTableViewCell", bundle: nil),
            forCellReuseIdentifier: "PlantSearchTableViewCell"
        )
    }
    
}

extension PlantSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlantSearchTableViewCell", for: indexPath) as! PlantSearchTableViewCell
        
        cell.plantImage.image = UIImage(named: "Kangkung")
        cell.plantName.text = "Kangkung \(indexPath.row + 1)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
}
