//
//  NotificationService.swift
//  Network
//
//  Created by sejin on 2023/09/09.
//  Copyright © 2023 SOPT-iOS. All rights reserved.
//

import Foundation
import Combine

import Moya

public typealias DefaultNotificationService = BaseService<NotificationAPI>

public protocol NotificationService {
    func getNotificationList(page: Int) -> AnyPublisher<[NotificationListEntity], Error>
    func readNotification(notificationId: Int) -> AnyPublisher<Int, Error>
}

extension DefaultNotificationService: NotificationService {
    
    public func getNotificationList(page: Int) -> AnyPublisher<[NotificationListEntity], Error> {
        requestObjectInCombine(.getNotificationList(page: page))
    }
    
    public func readNotification(notificationId: Int) -> AnyPublisher<Int, Error> {
        requestObjectInCombineNoResult(.readNotification(notificationId: notificationId))
    }
}
