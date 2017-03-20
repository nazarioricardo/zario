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
    
    @IBOutlet weak var waveformSelector: UISegmentedControl!
    @IBOutlet weak var noteSelector: UISegmentedControl!
    @IBOutlet weak var octaveSlider: UISlider!
    @IBOutlet weak var rangeSlider: UISlider!
    @IBOutlet weak var minFreqTextField: UITextField!
    @IBOutlet weak var maxFreqTextField: UITextField!
    @IBOutlet weak var octaveLabel: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!
    
    var octaveMultiplier: Int!
    
    @IBAction func octaveSliderChanged(_ sender: Any) {
        octaveMultiplier = Int(self.octaveSlider.value) + 1
        octaveLabel.text = String(Int(self.octaveSlider.value))
    }
    
    @IBAction func rangeSliderChanged(_ sender: Any) {
        rangeLabel.text = String(Int(rangeSlider.value))
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
                                    
                                    print(self.waveformSelector.selectedSegmentIndex)
                                    
                                    self.keyboardVC.chosenOctave = self.octaveMultiplier
                                    
                                    switch self.noteSelector.selectedSegmentIndex {
                                    case 0:
                                        self.keyboardVC.chosenNoteInterval = 3
                                    case 1:
                                        self.keyboardVC.chosenNoteInterval = 5
                                    case 2:
                                        self.keyboardVC.chosenNoteInterval = 7
                                    case 3:
                                        self.keyboardVC.chosenNoteInterval = 8
                                    case 4:
                                        self.keyboardVC.chosenNoteInterval = 10
                                    case 5:
                                        self.keyboardVC.chosenNoteInterval = 0
                                    case 6:
                                        self.keyboardVC.chosenNoteInterval = 2
                                    default:
                                        self.keyboardVC.chosenNoteInterval = 0
                                    }
                                    
                                    self.keyboardVC.modalTransitionStyle = .crossDissolve
//                                    self.keyboardVC.numberOfKeys *= 2
                                    self.keyboardVC.selectedIndex = self.waveformSelector.selectedSegmentIndex
                                    self.keyboardVC.numberOfKeys = Int(self.rangeSlider.value)
                                    self.keyboardVC.maxCutoff = Double(self.maxFreqTextField.text!)
                                    self.keyboardVC.minCutoff = Double(self.minFreqTextField.text!)
                                    
                                    self.present(self.keyboardVC, animated: true, completion: nil)
                                    print("Landscape")
                                }
        
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        octaveMultiplier = Int(self.octaveSlider.value) * 8 + 1
        octaveLabel.text = String(Int(self.octaveSlider.value) * 8)
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
