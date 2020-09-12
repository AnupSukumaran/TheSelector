//
//  NSObject.swift
//  TheSelector
//
//  Created by Sukumar Anup Sukumaran on 12/09/20.
//  Copyright © 2020 Manu Puthoor. All rights reserved.
//

import Foundation
import UIKit
import SASLoaderPod

enum Results<T> {
    case success(T)
    case failure(errorStr: String)
}

extension NSObject {
    static var identifier: String {
        return String(describing: self)
    }
    
    func injectInitalViewModel(window: UIWindow?) {
        if let navVC = window?.rootViewController as? UINavigationController {
            if let vc = navVC.topViewController as? HomeViewController {
                vc.homeViewModel = HomeViewModel(loader: vc.loader())
            }
        }
    }
    
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"), let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print("JSONErro = \(error.localizedDescription)")
        }
        return nil
    }

    
    func parse(jsonData: Data, handler: (Results<ModelResponse>) -> ()) {
      
       do {
           let modelResponse = try ModelResponse(data: jsonData)
           handler(.success(modelResponse))
       } catch {
           handler(.failure(errorStr: error.localizedDescription))
       }
       
       
    }
}

extension UIViewController {
    static let loader: (UIViewController) -> (LoaderView) = { (vc) in
        return LoaderView(callOn: vc, type: .lineScale, color: .red, padding: 25)
    }
    
    func loader() -> LoaderView {
        return UIViewController.loader(self)
    }
}
