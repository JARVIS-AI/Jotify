//
//  UIViewController+Extensions.swift
//  Jotify
//
//  Created by Harrison Leath on 1/18/21.
//

import UIKit
import AudioToolbox

extension UIViewController {
    //play haptic feedback from any viewcontroller
    func playHapticFeedback() {
        // iPhone 7 and newer
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    //add gesture recognizer to hide keyboard when view is tapped
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //set a new rootViewController with animation
    func setRootViewController(duration: Double, vc: UIViewController) {
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        UIView.transition(with: UIApplication.shared.windows.first!, duration: duration, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    //gets the current rootViewController from connected scenes
    func getRootViewController() -> UIViewController {
        return (UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first?.rootViewController)!
    }
    
    //change StatusBarStyle in parent, PageViewController
    //override and always make style light if in dark mode
    //**only call this method when PageViewController is present**
    func handleStatusBarStyle(style: UIStatusBarStyle) {
        let rootVC = UIApplication.shared.windows.first!.rootViewController as! PageBoyController
        if traitCollection.userInterfaceStyle == .dark {
            rootVC.statusBarStyle = .lightContent
        } else {
            rootVC.statusBarStyle = style
        }
        rootVC.setNeedsStatusBarAppearanceUpdate()
    }
}
