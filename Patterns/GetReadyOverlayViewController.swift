//
//  GetReadyOverlayViewController.swift
//  Patterns
//
//  Created by Mathias Iden on 18.04.2016.
//  Copyright © 2016 TDT4240G12. All rights reserved.
//

import UIKit

protocol countdownStarter {
    func startCountDown()
}

class GetReadyOverlayViewController: UIViewController {
    
    @IBOutlet weak var secondsLabel: UILabel!
    var counter = 1;
    var interval = NSTimer();
    var delegate: countdownStarter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondsLabel.hidden = true;
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GetReadyOverlayViewController.overlayTapped))
        view.addGestureRecognizer(tap)
        interval = setInterval(1) {
            if(self.counter == 0){
                self.dismissViewControllerAnimated(true) {
                    self.interval.invalidate()
                    self.delegate?.startCountDown()
                }
            }
            self.secondsLabel.text = String(self.counter)
            self.counter -= 1
        }
    }
    
    func overlayTapped(){
        self.dismissViewControllerAnimated(true) {
            self.interval.invalidate()
            self.delegate?.startCountDown()
        }
    }

}
