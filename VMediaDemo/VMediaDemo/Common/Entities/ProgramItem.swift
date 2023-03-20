//
//  ProgramItem.swift
//  VMediaDemo
//
//  Created by Abhishek Binniwale on 19/03/23.
//

import Foundation

struct ProgramItem: Codable {
    var startTime: String // program item start time in UTC
    var recentAirTime: RecentAirTime // program item ID and channel ID the program belongs to
    var length: Int // program length in minutes
    var name: String // Program name to display. Don't worry if it is too long, truncate it
}

struct RecentAirTime: Codable {
    var id: Int // program item ID
    var channelID: Int // its channel ID
}
