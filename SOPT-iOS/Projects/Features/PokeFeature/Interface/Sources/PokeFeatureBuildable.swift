//
//  PokeFeatureBuildable.swift
//  PokeFeatureInterface
//
//  Created by sejin on 12/7/23.
//  Copyright © 2023 SOPT-iOS. All rights reserved.
//

import Foundation

import Domain

public protocol PokeFeatureBuildable {
    func makePokeMain() -> PokeMainPresentable
    func makePokeMyFriends() -> PokeMyFriendsPresentable
    func makePokeOnboarding() -> PokeOnboardingPresentable
    func makePokeMessageTemplateBottomSheet() -> PokeMessageTemplatesPresentable
    func makePokeNotificationList() -> PokeNotificationPresentable
}
