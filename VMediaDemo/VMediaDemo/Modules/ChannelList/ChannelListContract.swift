//
//  ChannelListContract.swift
//  VMediaDemo
//
//  Created by Abhishek Binniwale
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewChannelListProtocol: AnyObject {
    func onFetchChannelListSuccess()
    func onFetchChannelListFailure(error: String)
    
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterChannelListProtocol: AnyObject {
    
    var view: PresenterToViewChannelListProtocol? { get set }
    var interactor: PresenterToInteractorChannelListProtocol? { get set }
    var router: PresenterToRouterChannelListProtocol? { get set }
    
    func viewDidLoad()
    
    func refresh()
    
    func numberOfItemsInSection(_ index: Int) -> Int
    func numberOfSection() -> Int
    func channelAt(index: Int) -> ChannelModel?
    func programAt(section: Int, row: Int) -> ProgramItem?
    func didSelectChannelAt(index: Int)
    func timeLabelText(index: Int) -> String
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorChannelListProtocol: AnyObject {
    
    var presenter: InteractorToPresenterChannelListProtocol? { get set }
    
    func loadChannelList()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterChannelListProtocol: AnyObject {
    
    func fetchChannelListSuccess(channels: [ChannelModel])
    func fetchChannelListFailure(error: String)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterChannelListProtocol: AnyObject {
    
    static func createModule() -> UIViewController
}
