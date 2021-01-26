//
//  ViewController.swift
//  Contact
//
//  Created by MUHAMMAD ALFARABY on 18/01/21.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var ref = Firestore.firestore()
    
    
    
    var contact = [Contact]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        
        loadContact()
        
        
    }
    
    
    
    func loadContact() {
        
        ref.collection("Contact")
            .order(by: "name")
            .addSnapshotListener { (snapshot, error) in
                
                self.contact = []
                
                for document in snapshot!.documents {
                    
                    let documentData = document.data()
                    
                    let id = document.documentID
                    if let phone = documentData["phone"] as? String , let name = documentData["name"] as? String , let address = documentData["address"] as? String    {
                        
                        let newContact = Contact(name: name, phone: phone, address: address, id: id)
                        
                        
                        print(newContact)
                        self.contact.append(newContact)
                        
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            
                        }
                    }
                }
                
            }
        
        
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        print(contact.count)
        return contact.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        cell.textLabel?.text = contact[indexPath.row].name
        cell.detailTextLabel?.text = contact[indexPath.row].phone
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailViewController(nibName: "DetailViewController", bundle: nil)
        
        detail.kontak = contact[indexPath.row]
        
        self.navigationController?.pushViewController(detail, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            ref.collection("Contact").document(String(contact[indexPath.row].id)).delete()
            contact.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }
    
    
    
    
}
