//
//  PokeMessageTemplatesPresentable.swift
//  PokeFeatureInterface
//
//  Created by Ian on 12/22/23.
//  Copyright © 2023 SOPT-iOS. All rights reserved.
//

import BaseFeatureDependency
import Core
import Domain

public protocol PokeMessageTemplatesViewControllable: ViewControllable { }

public protocol PokeMessageTemplatesCoordinatable { }

public typealias PokeMessageTemplatesViewModelType = ViewModelType & PokeMessageTemplatesCoordinatable
public typealias PokeMessageTemplatesPresentable = (vc: PokeMessageTemplatesViewControllable, vm: any PokeMessageTemplatesCoordinatable)

