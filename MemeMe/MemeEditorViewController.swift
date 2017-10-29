//
//  MemeViewController.swift
//  Meme Experiments
//
//  Created by Bruno Barbosa on 12/04/17.
//  Copyright © 2017 Bruno Barbosa. All rights reserved.
//

import UIKit
import Foundation

protocol MemeView: class {
    var topTextField: UITextField! { get set }
    var bottomTextField: UITextField!  { get set }
    
    func disableControls(_ disableControls:Bool)
}

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MemeView {
    
    @IBOutlet weak var memeView: UIView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var headerToolbar: UIToolbar!
    @IBOutlet weak var footerToolbar: UIToolbar!
    
    let memeTextFieldDelegate = MemeTextFieldDelegate()
    
    let defaultTopText = "TOP"
    let defaultBottomText = "BOTTOM"
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDefaults()
        memeTextFieldDelegate.memeView = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeToKeyboardNotifications()
    }
    
    func initializeDefaults() {
        topTextField.text = defaultTopText
        memeImageView.image = nil
        bottomTextField.text = defaultBottomText
        
        customizeAppearance()
        checkSharingAvailability()
        checkCameraAvailability()
    }
    
    func hasDefaultData() -> Bool {
        if (topTextField.text != defaultTopText) {
            return false
        }
        
        if (bottomTextField.text != defaultBottomText) {
            return false
        }
        
        if (memeImageView.image != nil) {
            return false
        }
        
        return true
    }
    
    func customizeAppearance() {
        let customFont = UIFont(name: "Anton-Regular", size:40.0)!
        setFont(customFont)
    }
    
    func setFont(_ font: UIFont) {
        let textFields = [topTextField, bottomTextField]
        
        let memeTextAttributes:[String:Any] = [
            NSStrokeColorAttributeName: UIColor.black,
            NSStrokeWidthAttributeName: -1.0,
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: font
        ]
        
        for textField in textFields {
            textField?.defaultTextAttributes = memeTextAttributes
            textField?.textAlignment = .center
            textField?.delegate = memeTextFieldDelegate
            textField?.autocapitalizationType = .allCharacters
        }
    }
    
    func checkCameraAvailability() {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    func checkSharingAvailability() {
        shareButton.isEnabled = (memeImageView.image == nil) ? false : true
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: [generateMemedImage()],
                                                              applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            
            if (success) {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
        present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func discardAllChanges(_ sender: Any) {
        if (!hasDefaultData()) {
            let alertController = UIAlertController(title: "Discart All Changes",
                                                    message: " Are you sure you want to discard the changes in the current meme?",
                                                    preferredStyle: .alert)
            
            let discardAction = UIAlertAction(title: "Discard", style: .destructive) { (discard) in
                self.dismiss(animated: true, completion: nil)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(discardAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion:nil)
            
        } else {
           dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func pickImageFromLibrary(_ sender: UIBarButtonItem) {
        pickImage(.photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: UIBarButtonItem) {
        pickImage(.camera)
    }
    
    func pickImage(_ sourceType: UIImagePickerControllerSourceType) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func changeFont(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Choose a font", message: nil, preferredStyle: .actionSheet)
        let antonFontOption = UIAlertAction(title: "Anton", style: .default) { (UIAlertAction) in
            let customFont = UIFont(name: "Anton-Regular", size:40.0)!
            self.setFont(customFont)
        }
        alertController.addAction(antonFontOption)
        
        let helveticaFontOption = UIAlertAction(title: "Helvetica Neue", style: .default) { (UIAlertAction) in
            let customFont = UIFont(name: "HelveticaNeue-CondensedBlack", size:40.0)!
            self.setFont(customFont)
        }
        alertController.addAction(helveticaFontOption)
        
        let cancelOption = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelOption)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func save() {
        let memedImage = generateMemedImage()
        let meme = Meme(topText: topTextField.text!,
                        bottomText: bottomTextField.text!,
                        originalImage: memeImageView.image!,
                        memedImage: memedImage)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        navigationController?.navigationBar.isHidden = true
        headerToolbar.isHidden = true
        footerToolbar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.memeView.frame.size)
        view.drawHierarchy(in: self.memeView.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        navigationController?.navigationBar.isHidden = false
        headerToolbar.isHidden = false
        footerToolbar.isHidden = false
        
        return memedImage
    }
    
    // MARK: - Keyboard
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name:.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name:.UIKeyboardWillHide,
                                               object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        if (bottomTextField.isEditing &&
            view.frame.origin.y == 0) {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0.0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImageView.image = image
        }
        
        picker.dismiss(animated: true) { 
            self.checkSharingAvailability()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            self.checkSharingAvailability()
        }
    }
    
    // MARK: - MemeView
    
    func disableControls(_ disableControls:Bool) {
        let barButtonItens = headerToolbar.items! + footerToolbar.items!
        
        if (disableControls) {
            for barButtonItem in barButtonItens {
                barButtonItem.isEnabled = false
            }
        } else {
            for barButtonItem in barButtonItens {
                barButtonItem.isEnabled = true
            }
            
            checkCameraAvailability()
            checkSharingAvailability()
        }
    }
}
