//
//  FeedViewController.swift
//  InstagramFirebase
//
//  Created by Tahir Bayraktar on 24.02.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseCore
import SDWebImage

class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var documentArrayId = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirebase()
    }
    
    func getDataFromFirebase(){
        
        let fireStoreDatabase = Firestore.firestore()
        
       /* --->Eski sürüm tarih hatası çözümü
        let setting = fireStoreDatabase.settings
        setting.areTimestampsInSnapshotsEnabled = true
        fireStoreDatabase.settings = setting
        */
        
        fireStoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            
            if error != nil{
                print(error?.localizedDescription ?? "Error!")
            }else{
                if snapshot?.isEmpty != true  && snapshot != nil{
                    
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.documentArrayId.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents{
                        let documentID = document.documentID
                        self.documentArrayId.append(documentID)
                        
                        if let postedBy = document.get("postedBy") as? String{
                            self.userEmailArray.append(postedBy)
                        }
                        if let postComment = document.get("postComment") as? String{
                            self.userCommentArray.append(postComment)
                        }
                        if let imageUrl = document.get("imageUrl") as? String{
                            self.userImageArray.append(imageUrl)
                           
                        }
                        if let likes = document.get("Likes") as? Int{
                            self.likeArray.append(likes)
                        }
                        self.tableView.reloadData()
                     }
                }
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        cell.documentIdLabel.text = documentArrayId[indexPath.row]
        
        
        return cell
    }

}
