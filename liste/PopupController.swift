//
//  PopupController.swift
//  liste
//
//  Created by tp on 12/03/2020.
//  Copyright © 2020 tp. All rights reserved.
//

import UIKit

class PopupController: UIViewController {
    @IBOutlet weak var texteField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func dismissPopup(_ sender: UIButton) {
        
        //code pour créer une nouvelle tache
        
        
        
        dismiss(animated: true, completion: nil)
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
