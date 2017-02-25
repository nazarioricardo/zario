//
//  BaseViewController.swift
//  Fretless
//
//  Created by Ricardo Nazario on 2/24/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    
    
    
    let keyboardVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "KeyBoardViewController") as! KeyBoardViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext) in
            
            if UIDevice.current.orientation.isPortrait {
                
                self.keyboardVC.dismiss(animated: true, completion: nil)
                print("Portrait")
                
            }
            
            
            
        },
                            completion: { (context: UIViewControllerTransitionCoordinatorContext) in
                                
                                if UIDevice.current.orientation.isLandscape {
                                    
                                    self.keyboardVC.modalTransitionStyle = .crossDissolve
//                                    self.keyboardVC.numberOfKeys *= 2
                                    self.present(self.keyboardVC, animated: true, completion: nil)
                                    print("Landscape")
                                }
        
        })
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
