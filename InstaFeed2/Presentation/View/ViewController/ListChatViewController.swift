//
//  ListChatViewController.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/21.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import UIKit
import Firebase

class ListChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var listView: UITableView!
    
    var senderDisplayName: String?
    var newChannelTextField: UITextField?
    private var channels: [Channel] = []
    
    private lazy var channelRef: DatabaseReference = Database.database().reference().child("channels")
    private var channelRefHandle: DatabaseHandle?
    
    enum Section: Int {
        case createNewChannelSection = 0
        case currentChannelSection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.delegate = self
        listView.dataSource = self
        self.title = senderDisplayName
//        channels.append(Channel(id: "1", name: "channel1"))
//        channels.append(Channel(id: "2", name: "channel2"))
//        channels.append(Channel(id: "3", name: "channel3"))
//        self.listView.reloadData()
        // Do any additional setup after loading the view.
        observeChannel()
        
    }
    
    deinit {
        if let refHandle = channelRefHandle {
            channelRef.removeObserver(withHandle: refHandle)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currentSection : Section = Section(rawValue: section) {
            switch currentSection {
            case .createNewChannelSection:
                return 1
            case .currentChannelSection:
                return channels.count
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = (indexPath as NSIndexPath).section == Section.createNewChannelSection.rawValue ?
        "NewChannel" : "ExistingChannel"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        if (indexPath as NSIndexPath).section == Section.createNewChannelSection.rawValue {
            if let createNewChannelCell = cell as? CreateChannelCell {
                newChannelTextField = createNewChannelCell.newChannelNameField
            }
        } else if (indexPath as NSIndexPath).section == Section.currentChannelSection.rawValue {
            cell.textLabel?.text = channels[(indexPath as NSIndexPath).row].name
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == Section.currentChannelSection.rawValue {
            let channel = channels[(indexPath as NSIndexPath).row]
            self.performSegue(withIdentifier: "showChatChannel", sender: channel)
        }
    }
    
    private func observeChannel() {
        
        //snapshot is one chanel data
        channelRefHandle = channelRef.observe(.childAdded, with: {(snapshot) -> Void in
            let channelData = snapshot.value as! Dictionary<String, AnyObject>
            let id = snapshot.key
            if let name = channelData["name"] as! String!, name.count > 0 {
                self.channels.append(Channel(id: id, name: name))
                self.listView.reloadData()
            } else {
                print("error! could not decode channel data")
            }
        })
    }
    
    @IBAction func createChannel(_ sender: Any) {
        if let name = newChannelTextField?.text {
            let newChannelRef = channelRef.childByAutoId() //create channel ref by unique key, create id automatically
            let channelItem = [
                "name": name
            ]
            newChannelRef.setValue(channelItem)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let channel = sender as? Channel {
            let chatVC = segue.destination as! ChatViewController
            
            chatVC.senderDisplayName = senderDisplayName
            chatVC.channel = channel
            chatVC.channelPref = channelRef.child(channel.id)
        }
    }
    
}
