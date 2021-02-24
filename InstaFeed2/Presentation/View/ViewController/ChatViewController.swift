//
//  ChatViewController.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/25.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController
import Photos

class ChatViewController: JSQMessagesViewController {
    
    var messages = [JSQMessage]()
    var channelPref: DatabaseReference?
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageview: JSQMessagesBubbleImage = self.setupInComingBubble()
    lazy var storageRef: StorageReference = Storage.storage().reference(forURL: "gs://instafeed2-6848d.appspot.com")
    
    private lazy var messageRef: DatabaseReference? = self.channelPref!.child("messages")
    private lazy var usersTypingQuery: DatabaseQuery = self.channelPref!.child("typingIndicator").queryOrderedByValue().queryEqual(toValue: true)
    
    private lazy var userIsTypingRef: DatabaseReference = self.channelPref!.child("typingIndicator").child(self.senderId)
    private var localTyping = false
    private let imageURLNotSetKey = "NOTSET"
    var isTyping: Bool {
        get {
            return localTyping
        }
        set {
            localTyping = newValue
            userIsTypingRef.setValue(newValue)
        }
    }
    private var newMessageRefHandle: DatabaseHandle?
    var channel: Channel? {
        didSet {
            title = channel?.name
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//
//        if let channel = sender as? Channel {
//            let chatVC = segue.destination as! ChatViewController
//            chatVC.channel = channel
//            chatVC.channelPref = channelPref?.child(channel.id)
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.senderId = Auth.auth().currentUser?.uid
        
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        observMessage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }

    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    private func setupInComingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            return outgoingBubbleImageView
        } else {
            return incomingBubbleImageview
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            cell.textView?.textColor = UIColor.white
        } else {
            cell.textView?.textColor = UIColor.black
        }
        return cell
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let itemRef = messageRef?.childByAutoId()
        let messageItem = [
            "senderId": senderId!,
            "senderName": senderDisplayName!,
            "text": text!
        ]
        itemRef?.setValue(messageItem)
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        finishSendingMessage()
        isTyping = false
    }
    
    private func addMessage(withId id: String, name: String, text: String) {
        if let message = JSQMessage(senderId: id, displayName: name, text: text) {
            messages.append(message)
        }
    }
    
    private func observMessage() {
        messageRef = channelPref!.child("messages")
        
        let messageQuery = messageRef?.queryLimited(toLast: 25)
        
        newMessageRefHandle = messageQuery?.observe(.childAdded, with: { (snapshot) -> Void in
            
            let messageData = snapshot.value as! Dictionary<String, String>
            
            if let id = messageData["senderId"] as String!, let name = messageData["senderName"] as String!,
                let text = messageData["text"] as String!, text.count > 0 {
                self.addMessage(withId: id, name: name, text: text)
                self.finishSendingMessage()
            } else {
                print("Error, could not decode message data")
            }
        })
    }
    
    override func textViewDidChange(_ textView: UITextView) {
        super.textViewDidChange(textView)
        print(isTyping = textView.text != "")
    }
    
    private func observeTyping() {
        let typingIndicatorRef = channelPref!.child("typingIndicator")
        userIsTypingRef = typingIndicatorRef.child(senderId)
        userIsTypingRef.onDisconnectRemoveValue()
        
        usersTypingQuery.observe(.value, with: {(data: DataSnapshot) in
            if data.childrenCount == 1 && self.isTyping {
                return
            }
            
            self.showTypingIndicator = data.childrenCount > 0
            self.scrollToBottom(animated: true)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        observeTyping()
    }
    
    func sendPhotoMessage() -> String? {
        let itemRef = messageRef?.childByAutoId()
        let messageItem = [
            "photoURL": imageURLNotSetKey,
            "senderId": senderId!
        ]
        
        itemRef?.setValue(messageItem)
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        finishSendingMessage()
        return itemRef?.key
    }
    
    func setImageURL(_ url: String, forPhotoMessageWithKey key: String) {
    let itemRef = messageRef?.child(key)
        itemRef?.updateChildValues(["photoURL": url])
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        let picker = UIImagePickerController()
//        picker.delegate = self
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            picker.sourceType = UIImagePickerControllerSourceType.camera
        } else {
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
}
