//
//  NetworkAppLifecycleListener.swift
//  Networks
//
//  Created by Ian on 12/3/23.
//  Copyright © 2023 SOPT-iOS. All rights reserved.
//

import Core

import Foundation

final public class NetworkAppLifecycleListener {
    private let authService: AuthService
    private let cancelBag = CancelBag()
    
    public init(authService: AuthService = DefaultAuthService()) {
        self.authService = authService
    }
}

// MARK: - Public functions
extension NetworkAppLifecycleListener: AppLifecycleListenable {
    public func register() {
        NotificationCenter.default
            .publisher(for: .SOPT.willEnterForeground)
            .withUnretained(self)
            .sink(receiveValue: { _ in
                self.onWillEnterForeground()
            }).store(in: self.cancelBag)
    }
}

// MARK: - Private functions
extension NetworkAppLifecycleListener {
    private func onWillEnterForeground() {
        guard UserDefaultKeyList.Auth.appAccessToken != nil else { return }
        
        self.authService.reissuance { _ in }
    }
}
