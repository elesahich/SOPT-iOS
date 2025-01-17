//
//  NotificationListTransform.swift
//  NotificationFeature
//
//  Created by sejin on 2023/06/14.
//  Copyright © 2023 SOPT-iOS. All rights reserved.
//

import Foundation

import Domain
import Network

extension NotificationListEntity {
    public func toDomain() -> NotificationListModel {
        return NotificationListModel.init(id: id,
                                          userId: userId,
                                          title: title,
                                          content: content,
                                          type: type,
                                          isRead: isRead,
                                          createdAt: createdAt,
                                          updatedAt: updatedAt)
    }
}
