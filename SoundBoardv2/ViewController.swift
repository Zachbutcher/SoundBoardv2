//
//  ViewController.swift
//  SoundBoardv2
//
//  Created by Zach Butcher on 7/27/17.
//  Copyright © 2017 Zach Butcher. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var dataAccess :DataAccess = DataAccess()
    var audioPlayer :AVAudioPlayer?
    
    override func viewWillAppear(_ animated: Bool) {
        //getShoes(filterString: nil)
        refreshTable()
        
    }
    
    func refreshTable(){
        dataAccess.refreshRecordings()
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

        do{
            audioPlayer = try AVAudioPlayer(data: dataAccess.recordings[indexPath.row].recording! as Data)
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        }catch{
            
        }

        //dataAccess.recordings[indexPath.row].recording
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            dataAccess.delete(name: dataAccess.recordings[indexPath.row])
            refreshTable()
        }
    }

}

