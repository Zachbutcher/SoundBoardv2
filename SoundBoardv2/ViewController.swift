//
//  ViewController.swift
//  SoundBoardv2
//
//  Created by Zach Butcher on 7/27/17.
//  Copyright © 2017 Zach Butcher. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var dataAccess :DataAccess = DataAccess()
    
    override func viewWillAppear(_ animated: Bool) {
        //getShoes(filterString: nil)
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataAccess.recordings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let recording = dataAccess.recordings[indexPath.row]
        
        cell.textLabel?.text = recording.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let shoe = shoes[indexPath.row]
        performSegue(withIdentifier: "createSound", sender: nil)
    }



}

