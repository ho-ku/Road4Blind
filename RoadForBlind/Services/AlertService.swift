//
//  AlertService.swift
//  RoadForBlind
//
//  Created by Денис Андриевский on 26.11.2020.
//

import UIKit

final class AlertService {
    
    static func presentSimpleOKAlert(_ viewController: UIViewController, title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: C.okTitle, style: .default, handler: nil))
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}
