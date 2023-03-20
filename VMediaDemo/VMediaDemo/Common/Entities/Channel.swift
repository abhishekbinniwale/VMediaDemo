//
//  Channel.swift
//  VMediaDemo
//
//  Created by Abhishek Binniwale on 19/03/23.
//

import Foundation

struct Channel: Codable {
    
    var orderNum: Int // order of the channel in the TV Guide
    var accessNum: Int // Channel access and display number
    var CallSign: String // Channel CallSIgn - shown in TV Guide - don't worry if it is long - truncate it
    var id: Int         // channel ID
}

