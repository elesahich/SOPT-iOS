//
//  AppLifecycleListener.swift
//  SOPT-iOS
//
//  Created by Ian on 12/3/23.
//  Copyright © 2023 SOPT-iOS. All rights reserved.
//

import Core
import Networks

import UIKit

final public class AppLifecycleAdapter {
    private let cancelBag = CancelBag()
    
    // MARK: Listeners
    private var appLifecycleListeners: [any AppLifecycleListenable] = []

    public init() {
        self.prepare()
    }
}

// MARK: - Public functions
extension AppLifecycleAdapter {
    public func start() {
        self.appLifecycleListeners = [NetworkAppLifecycleListener()]
        
        self.appLifecycleListeners.forEach { $0.register() }
    }
}

// MARK: - Private functions
extension AppLifecycleAdapter {
    private func prepare() {
        self.onWillEnterForeground()
        self.onWillEnterBackground()
    }

    //MARK: - Usecases
    private func onWillEnterForeground() {
        NotificationCenter.default
            .publisher(for: UIApplication.willEnterForegroundNotification)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                NotificationCenter.default.post(name: .SOPT.willEnterForeground, object: nil)
            }).store(in: self.cancelBag)
    }

    private func onWillEnterBackground() { }
}
