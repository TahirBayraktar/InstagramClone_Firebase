//
//  UploadViewController.swift
//  InstagramFirebase
//
//  Created by Tahir Bayraktar on 24.02.2023.
//

import UIKit

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
}
