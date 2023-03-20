//
//  ChannelListInteractor.swift
//  VMediaDemo
//
//  Created by Abhishek Binniwale on 19/03/23.
//

import Foundation

class ChannelListInteractor: PresenterToInteractorChannelListProtocol {
    
    // MARK: Properties
    weak var presenter: InteractorToPresenterChannelListProtocol?
    var channelModels = [ChannelModel]()
    
    func loadChannelList() {
        ChannelListService.shared.getChannels(count: 0) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let channels):
                ProgramItemListService.shared.getProgramItemList { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let programs):
                        self.creatChannelModelList(channels: channels, programs: programs)
                    case .failure(let error):
                        self.presenter?.fetchChannelListFailure(error: error.localizedDescription)
                    }
                }
            case .failure(let error):
                self.presenter?.fetchChannelListFailure(error: error.localizedDescription)
            }
        }
    }
    
    func creatChannelModelList(channels: [Channel], programs: [ProgramItem]) {
        for channel in channels {
            let prgramItems = programs.filter { $0.recentAirTime.channelID == channel.id }
            let channelModel = ChannelModel(orderNum: channel.orderNum,
                                            accessNum: channel.accessNum,
                                            CallSign: channel.CallSign,
                                            id: channel.id,
                                            prgrams: prgramItems)
            self.channelModels.append(channelModel)
        }
        self.presenter?.fetchChannelListSuccess(channels: channelModels)
    }

}
