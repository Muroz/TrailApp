//
//  PopUpViewController.swift
//  eastCoastTrailApp
//
//  Created by Diego Zuluaga on 2017-04-25.
//  Copyright © 2017 Diego Zuluaga. All rights reserved.
//

import Foundation
import UIKit

class PopUpViewController : UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!

    @IBOutlet weak var messageLabel: UITextView!

    @IBOutlet weak var popUpView: UIView!
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        //var backG = UIColor(patternImage: UIImage(named: "camBack.jpg")!)
        self.popUpView.backgroundColor = UIColor(white:1,alpha:0.5)
        self.popUpView.layer.cornerRadius = 5
        self.popUpView.layer.shadowOpacity = 0.8
        self.popUpView.layer.shadowOffset = CGSize(width:0.0, height:0.0)
    }
    
    open func showInView(aView: UIView!, withImage image : UIImage!, withMessage message: String!, animated: Bool)
    {
        

        aView.addSubview(self.view)
        popUpView.backgroundColor = UIColor(patternImage: UIImage(named: "camBack.jpg")!).withAlphaComponent(0.5)
        logoImage!.image = image
        messageLabel!.text = message
        messageLabel!.backgroundColor = UIColor(white:1,alpha:0.7)
        if animated
        {
            self.showAnimate()
        }
    }

    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    @IBAction func closePopup(sender: AnyObject){
        self.removeAnimate()
    }
    


}
