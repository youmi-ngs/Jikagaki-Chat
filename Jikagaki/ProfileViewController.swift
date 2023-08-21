//
//  ProfileViewController.swift
//  Jikagaki
//
//  Created by Youmi Nagase on 2023/08/21.
//

import UIKit

class ProfileViewController: UIViewController {
    


    @IBOutlet weak var userNameTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = UserDefaults.standard.string(forKey: "name") {
            userNameTextfield.text = name
        }
    }
    
    @IBAction func handleTextChange() {
        let text = userNameTextfield.text
        print(userNameTextfield.text ?? "(null)")
        UserDefaults.standard.setValue(text, forKey: "name")
    }
}



 


