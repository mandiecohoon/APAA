//
//  FirstViewController.swift
//  AlumniAppSwift
//
//  Created by Amanda Cohoon on 2015-07-20.
//  Copyright (c) 2015 Amanda Cohoon. All rights reserved.
//

import UIKit
import WebKit

class CardViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // sets user default for determining if app is on first launch
        let lauched = NSUserDefaults.standardUserDefaults().boolForKey("Launched")
        
        if lauched  {
            // App has been launched before: continue on
        } else {
            //First launch
            // Send seque to launch registration view modal
            self.performSegueWithIdentifier("ShowRegSegue", sender: self)
            
            // Sets lauched to true
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "Launched") // Should be true. Set to false for debugging
        }
    }
    
    // iPad: when device rotated, view bounds change: this accomidates for missaligned popover when rotated. Dismisses the view and re-calls it to be drawn again.
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        dismiss()
        self.performSegueWithIdentifier("ShowRegSegue", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Listens for segue to be called
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowRegSegue") {
            // sets delegate and set view uo for popover
            let vc: AnyObject = segue.destinationViewController
            vc.popoverPresentationController!!.delegate = self
            return
        }
    }
    
    
    // For iPad only: Confirms that the user no longer needs the register form: function added to avoid accidentally closing the reg form when iPad user launches app for the first time.
    func confirmDismissRegistration() -> Bool {
        var shouldDismiss = true
        
        // Create the alert controller
        var alertController = UIAlertController(title: "Close Registration Form", message: "Are you sure you want to close the registration form? You will no longer be able to register.", preferredStyle: .Alert)
        
        // Create the actions
        // cancel action returns to the form
        var cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            shouldDismiss = false
            self.performSegueWithIdentifier("ShowRegSegue", sender: self)
        }
        // ok action dismisses the view and will not longer show the form again
        var okAction = UIAlertAction(title: "I've Registered", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            shouldDismiss = true
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        presentViewController(alertController, animated: true, completion: nil)
        
        // Returns the user's decision
        return shouldDismiss
    }
    
}

// Delegate extension to create the navigation controller and the close button
extension CardViewController: UIPopoverPresentationControllerDelegate {
    
    func popoverPresentationControllerShouldDismissPopover(popoverPresentationController: UIPopoverPresentationController) -> Bool {
        // Dismissed the popover to clear the presenting view: makes room for alert view to be presented
        dismiss()
        
        // Calls the method to ask the user to confirm closing the reg form: method returns boolean
        let shouldDismiss = confirmDismissRegistration()
        
        return shouldDismiss
    }
    
    // Presents popover view as modal when on iPhone & creates a navigation bar/done button for user to dismiss form
    func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        let btnDone = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "dismiss") // create done button & gives action for dismiss
        
        let nav = UINavigationController(rootViewController: controller.presentedViewController) // sets nav bar
        nav.topViewController.navigationItem.rightBarButtonItem = btnDone // adds done button to nav bar
        
        nav.topViewController.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()] // Change the color of the title in the navigation bar (sweet long code just for a color change)
        UIBarButtonItem.appearance().tintColor = UIColor(red:120/255, green:206/255, blue:214/255, alpha:1.0)
        nav.topViewController.navigationItem.rightBarButtonItem!.tintColor = UIColor.whiteColor() // sets done button color to white without changing the view's tint to white
        
        return nav
    }

    //Dismiss the view
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
