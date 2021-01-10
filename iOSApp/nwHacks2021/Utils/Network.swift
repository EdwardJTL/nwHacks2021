//
//  Network.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-10.
//

import Foundation

let serverAddr = "https://bab76b437796.ngrok.io"
let aliceUserID = "aihli"

func buildGETFriendEndpoint(userID: String) -> String {
    return serverAddr + "/friend/\(userID)"
}

func buildGETNewsfeed(userID: String) -> String {
    return serverAddr + "/newsfeed/\(userID)"
}

func buildGETComments(postAuthorID: String, postID: String) -> String {
    return serverAddr + "/comments/\(postAuthorID)/\(postID)"
}

func buildGETSkills(userID: String) -> String {
    return serverAddr + "/skills/\(userID)"
}

func buildGETProfile(userID: String) -> String {
    return serverAddr + "/profile/\(userID)"
}
