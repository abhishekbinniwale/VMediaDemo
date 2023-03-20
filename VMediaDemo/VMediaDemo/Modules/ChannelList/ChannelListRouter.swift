//
//  ChannelListRouter.swift
//  VMediaDemo
//
//  Created by Abhishek Binniwale on 19/03/23.
//

import UIKit

class ChannelListRouter: PresenterToRouterChannelListProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        print("ChannelListRouter creates the ChannelList module.")
        let view = mainstoryboard.instantiateViewController(withIdentifier: "ChannelLisViewControllerIdentifier") as! ChannelLisViewController
        
        let presenter: ViewToPresenterChannelListProtocol & InteractorToPresenterChannelListProtocol = ChannelListPresenter()
        let interactor = ChannelListInteractor()
        let router =  ChannelListRouter()
        
        view.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
}
