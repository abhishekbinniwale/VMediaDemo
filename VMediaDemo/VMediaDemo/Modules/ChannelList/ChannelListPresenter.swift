//
//  ChannelListPresenter.swift
//  VMediaDemo
//
//  Created by Abhishek Binniwale on 19/03/23.
//

import Foundation

class ChannelListPresenter: ViewToPresenterChannelListProtocol {
    // MARK: Properties
    weak var view: PresenterToViewChannelListProtocol?
    var interactor: PresenterToInteractorChannelListProtocol?
    var router: PresenterToRouterChannelListProtocol?
    var channelModels = [ChannelModel]()
    
    func viewDidLoad() {
        self.fetchChannelList()
    }
    
    func refresh() {
        self.fetchChannelList()
    }
    
    func fetchChannelList() {
        interactor?.loadChannelList()
    }
    
    func numberOfItemsInSection(_ index: Int) -> Int {
        return channelModels[index].prgrams?.count ?? 0
    }
    
    func numberOfSection() -> Int {
        return channelModels.count
    }
    
    func didSelectChannelAt(index: Int) {
        
    }
    
    func channelAt(index: Int) -> ChannelModel? {
        return self.channelModels[index]
    }
    
    func programAt(section: Int, row: Int) -> ProgramItem? {
        let channel = channelModels[section]
        return channel.prgrams?[row]
    }
    
    func timeLabelText(index: Int) -> String {
        return ""
    }
}

// MARK: - Outputs to view
extension ChannelListPresenter: InteractorToPresenterChannelListProtocol {
    
    func fetchChannelListSuccess(channels: [ChannelModel]) {
        print("Presenter receives the result from Interactor after it's done its job.")
        self.channelModels.append(contentsOf: channels)
        view?.onFetchChannelListSuccess()
    }
    
    func fetchChannelListFailure(error: String) {
        print("Presenter receives the result from Interactor after it's done its job.")
        view?.onFetchChannelListFailure(error: "Couldn't fetch countries: \(error)")
    }
    
}
