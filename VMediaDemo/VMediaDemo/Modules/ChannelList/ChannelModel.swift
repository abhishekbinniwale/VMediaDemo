//
//  ChannelModel.swift
//  VMediaDemo
//
//  Created by Abhishek Binniwale on 20/03/23.
//

import Foundation

class ChannelModel {
    var orderNum: Int = 0
    var accessNum: Int = 0
    var CallSign: String = ""
    var id: Int = 0
    var prgrams: [ProgramItem]?
    
    init(orderNum: Int, accessNum: Int, CallSign: String, id: Int, prgrams: [ProgramItem]? = nil) {
        self.orderNum = orderNum
        self.accessNum = accessNum
        self.CallSign = CallSign
        self.id = id
        self.prgrams = prgrams
    }
}
