//
//  ListJokeBuilder.swift
//  project
//
//  Created by carlos alfredo llerena huayta on 23.02.22.
//

import Foundation
import UIKit

class ListJokeBuilder {

    
    func makeScene() -> ListJokeViewController {
        let viewController = ListJokeViewController()
        let presenter = ListJokePresenter(view: viewController)
        viewController.presenter = presenter
        
        return viewController
    
    }
}
