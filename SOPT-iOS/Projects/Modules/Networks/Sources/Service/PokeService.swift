//
//  PokeService.swift
//  Networks
//
//  Created by sejin on 12/19/23.
//  Copyright © 2023 SOPT-iOS. All rights reserved.
//

import Foundation
import Combine

import Moya

public typealias DefaultPokeService = BaseService<PokeAPI>

public protocol PokeService {
    func getWhoPokedToMe() -> AnyPublisher<PokeUserEntity?, Error>
    func getFriend() -> AnyPublisher<[PokeUserEntity], Error>
    func getFriendRandomUser() -> AnyPublisher<[PokeFriendRandomUserEntity], Error>
    func getFriendList() -> AnyPublisher<PokeMyFriendsEntity, Error>
    func getRandomUsers() -> AnyPublisher<[PokeUserEntity], Error>
    func getPokeMessages(messageType: PokeMessageType) -> AnyPublisher<PokeMessagesEntity, Error>
    func poke(userId: Int, message: String) -> AnyPublisher<PokeUserEntity, Error>
}

extension DefaultPokeService: PokeService {
    public func getWhoPokedToMe() -> AnyPublisher<PokeUserEntity?, Error> {
        requestObjectInCombine(.getWhoPokedToMe)
    }
    
    public func getFriend() -> AnyPublisher<[PokeUserEntity], Error> {
        requestObjectInCombine(.getFriend)
    }
    
    public func getFriendRandomUser() -> AnyPublisher<[PokeFriendRandomUserEntity], Error> {
        requestObjectInCombine(.getFriendRandomUser)
    }
    
    public func getFriendList() -> AnyPublisher<PokeMyFriendsEntity, Error> {
        requestObjectInCombine(.getFriendList)
    }
    
    public func getRandomUsers() -> AnyPublisher<[PokeUserEntity], Error> {
        requestObjectInCombine(.getRandomUsers)
    }
    
    public func getPokeMessages(messageType: PokeMessageType) -> AnyPublisher<PokeMessagesEntity, Error> {
        requestObjectInCombine(.getPokeMessages(messageType: messageType))
    }
    
    public func poke(userId: Int, message: String) -> AnyPublisher<PokeUserEntity, Error> {
        let params: [String: Any] = ["message": message]
        
        return requestObjectInCombine(.poke(userId: String(describing: userId), params: params))
    }
}
