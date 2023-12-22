//
//  PokeNotificationPresentable.swift
//  PokeFeatureDemo
//
//  Created by Ian on 12/22/23.
//  Copyright © 2023 SOPT-iOS. All rights reserved.
//

import BaseFeatureDependency
import Core
import Domain

public protocol PokeNotificationViewControllable: ViewControllable { }

public protocol PokeNotificationCoordinatable {
    var onNaviBackTapped: (() -> Void)? { get set }
}

public typealias PokeNotificationViewModelType = ViewModelType & PokeNotificationCoordinatable
public typealias PokeNotificationPresentable = (vc: PokeNotificationViewControllable, vm: any PokeNotificationViewModelType)

