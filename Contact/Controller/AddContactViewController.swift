//
//  AddContactViewController.swift
//  Contact
//
//  Created by MUHAMMAD ALFARABY on 18/01/21.
//

import UIKit
import Firebase


class AddContactViewController: UIViewController {
    
    
    var ref = Firestore.firestore()
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var address: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func submit(_ sender: UIButton) {
        
        
        let submitted: [String: String] = [
            "name": name.text! ,
            "phone": phone.text! ,
            "address": address.text! ]
        ref.collection("Contact").addDocument(data: submitted)
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
}
