//
//  UploadViewController.swift
//  InstagramFirebase
//
//  Created by Tahir Bayraktar on 24.02.2023.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class UploadViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            
          imageView.isUserInteractionEnabled = true
          let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
          imageView.addGestureRecognizer(imageTapRecognizer)
    }
    @objc func selectImage(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
        }
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    func makeAlert(inputTittle:String,inputMessage:String){
        let alert = UIAlertController(title: inputTittle, message:inputMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    @IBAction func uploadClicked(_ sender: Any) {
//        dosya referansı oluştur
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
//      kullanıcı birden fazla fotoğraf yüklemesi için id veriyoruz
        let uuid = UUID().uuidString
//        image->data'ya dönüştürme
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data) { metadata, error in
                
                if error != nil{
                    self.makeAlert(inputTittle: "Error!", inputMessage: error?.localizedDescription ?? "Error!")
                }else{
                    imageReference.downloadURL { url, error in
                        
                        if error == nil{
                            let imageUrl = url?.absoluteString
//                            DATABASE
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            var firestoreReference : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl" : imageUrl ?? "1234" , "postedBy" : Auth.auth().currentUser!.email! , "postComment" : self.commentText.text! , "date" : FieldValue.serverTimestamp() , "Likes" : 0] as [String:Any]
                            
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost,completion: { error in
                                
                                if error != nil {
                                    self.makeAlert(inputTittle: "Error!", inputMessage: error?.localizedDescription ?? "Error" )
                                }else{
                                    self.imageView.image = UIImage(named: "selectimages")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                    
                                }
                            })
                            
                        }
                    }
                    
                }
            }
        }
            
        
        
    }
    
}
