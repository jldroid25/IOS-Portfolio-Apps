//
//  UIViewController+Helpers.swift
//  Nevictus
//
//  Created by JL on 6/6/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

extension UIViewController {
    
    //Extension/helper methods
    
    //Adding top right Btn to add employees
    func setupPlusButtonInNavBar(selector: Selector){
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "add_box2"),style: .plain, target: self, action: selector)
    }
    
    //Adding top left Btn to cancel modal screen
    func setupCancelButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
style: .plain, target: self, action: #selector(handleCancelModal))
    }
    
    //Cancel the VC 
    @objc func handleCancelModal() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupLightBlueBackgroundView(height: CGFloat) -> UIView {
    //bgColor for the add Company view
    let lightBlueBackGroundView = UIView()
    lightBlueBackGroundView.backgroundColor = .lightBlue
    lightBlueBackGroundView.translatesAutoresizingMaskIntoConstraints = false
        
    view.addSubview(lightBlueBackGroundView)
        
    lightBlueBackGroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    lightBlueBackGroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    lightBlueBackGroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    lightBlueBackGroundView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        return lightBlueBackGroundView
    }

        
}
