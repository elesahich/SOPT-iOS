//
//  NotificationCoordinator.swift
//  NotificationFeatureInterface
//
//  Created by Junho Lee on 2023/06/21.
//  Copyright © 2023 SOPT-iOS. All rights reserved.
//

import Core
import BaseFeatureDependency
import NotificationFeatureInterface
import Domain

public
final class NotificationCoordinator: DefaultCoordinator {
    
    public var finishFlow: (() -> Void)?
    
    private let factory: NotificationFeatureBuildable
    private let router: Router
    
    public init(router: Router, factory: NotificationFeatureBuildable) {
        self.factory = factory
        self.router = router
    }
    
    public override func start() {
        showNotifcationList()
    }
    
    private func showNotifcationList() {
        var notificiationList = factory.makeNotificationList()
        notificiationList.vm.onNaviBackButtonTap = { [weak self] in
            self?.router.popModule()
            self?.finishFlow?()
        }
        notificiationList.vm.onNotificationTap = { [weak self] notification in
            self?.showNotificationDetail(notification: notification)
        }
        router.push(notificiationList.vc)
    }
    
    private func showNotificationDetail(notification: NotificationListModel) {
        let notificationDetail = factory.makeNotificationDetailVC(notification: notification)
        router.push(notificationDetail)
    }
}
