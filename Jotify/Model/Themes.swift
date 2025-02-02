//
//  Themes.swift
//  Jotify
//
//  Created by Harrison Leath on 7/16/19.
//  Copyright © 2019 Harrison Leath. All rights reserved.
//

import UIKit

struct InterfaceColors {
    // colors for light/dark mode toggle
    static var viewBackgroundColor = UIColor()
    static var navigationBarColor = UIColor()
    static var cellColor = UIColor()
    static var fontColor = UIColor()
    static var writeViewColor = UIColor()
    static var searchBarColor = UIColor()
    static var actionSheetColor = UIColor()
    static var separatorColor = UIColor()
}

class Themes {
    func setupVibrantDarkMode() {
        InterfaceColors.writeViewColor = UIColor.grayBackground
        InterfaceColors.viewBackgroundColor = UIColor.grayBackground
        InterfaceColors.cellColor = UIColor.cellDark
        InterfaceColors.fontColor = .white
        InterfaceColors.navigationBarColor = UIColor.grayBackground
        InterfaceColors.searchBarColor = UIColor.grayBackground
        InterfaceColors.actionSheetColor = UIColor.grayBackground
        InterfaceColors.separatorColor = .white
    }

    func setupPureDarkMode() {
        InterfaceColors.writeViewColor = .black
        InterfaceColors.viewBackgroundColor = .black
        InterfaceColors.cellColor = UIColor.cellPureDark ?? UIColor.cellDark
        InterfaceColors.fontColor = .white
        InterfaceColors.navigationBarColor = .black
        InterfaceColors.searchBarColor = .black
        InterfaceColors.actionSheetColor = .black
        InterfaceColors.separatorColor = .white
    }

    func setupDefaultMode() {
        InterfaceColors.viewBackgroundColor = .white
        InterfaceColors.navigationBarColor = .white
        InterfaceColors.searchBarColor = .white
        InterfaceColors.cellColor = UIColor.cellLight
        InterfaceColors.fontColor = .black
    }
    
    func triggerSystemMode(mode: UITraitCollection) {
        if UserDefaults.standard.bool(forKey: "useSystemMode") {
            if mode.userInterfaceStyle == .light {
                setupDefaultMode()
                UserDefaults.standard.set(false, forKey: "darkModeEnabled")
                UserDefaults.standard.set(false, forKey: "vibrantDarkModeEnabled")
                UserDefaults.standard.set(false, forKey: "pureDarkModeEnabled")
                UIApplication.shared.windows.first?.backgroundColor = StoredColors.noteColor
            } else if mode.userInterfaceStyle == .dark {
                setupVibrantDarkMode()
                UserDefaults.standard.set(true, forKey: "darkModeEnabled")
                UserDefaults.standard.set(true, forKey: "vibrantDarkModeEnabled")
            } else {
                setupDefaultMode()
                UserDefaults.standard.set(false, forKey: "darkModeEnabled")
                UserDefaults.standard.set(false, forKey: "vibrantDarkModeEnabled")
                UserDefaults.standard.set(false, forKey: "pureDarkModeEnabled")
            }
        }
    }
    
    func darkModeEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: "darkModeEnabled")
    }
    
    func setupPersistentNavigationBar(navController: UINavigationController) {
        navController.navigationBar.backgroundColor = InterfaceColors.navigationBarColor
        navController.navigationBar.barTintColor = InterfaceColors.navigationBarColor
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.setBackgroundImage(nil, for: .default)
        navController.navigationBar.isTranslucent = false
        
        if darkModeEnabled() {
            navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navController.navigationBar.barStyle = .black
            
        } else {
            navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            navController.navigationBar.barStyle = .default
        }
    }
    
    func setStatusBar(traitCollection: UITraitCollection) -> UIStatusBarStyle {
        if UserDefaults.standard.bool(forKey: "useSystemMode") == false && UserDefaults.standard.bool(forKey: "darkModeEnabled") == false {
            return .darkContent
        } else if UserDefaults.standard.bool(forKey: "useSystemMode") == false && UserDefaults.standard.bool(forKey: "darkModeEnabled") {
            return .lightContent
        } else if UserDefaults.standard.bool(forKey: "useSystemMode") && traitCollection.userInterfaceStyle == .light {
            return .darkContent
        } else {
            return .lightContent
        }
    }
}
