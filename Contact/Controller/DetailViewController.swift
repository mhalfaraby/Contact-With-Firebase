//
//  DetailViewController.swift
//  Contact
//
//  Created by MUHAMMAD ALFARABY on 26/01/21.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {
    var kontak: Contact?
    var ref = Firestore.firestore()

    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var address: UITextField!
    var id: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        id = kontak?.id
        if let result = kontak {
                       name?.text = result.name
                       phone?.text = result.phone
                       address?.text = result.address
                        
                   }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func update(_ sender: UIButton) {
//
        
        let submitted: [String: String] = [
            "name": name.text! ,
            "phone": phone.text! ,
            "address": address.text! ]
//
        ref.collection("Contact").document(id!).setData(submitted)
     
        self.navigationController?.popToRootViewController(animated: true)
    
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
