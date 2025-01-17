//
//  ServiceType.swift
//  Core
//
//  Created by sejin on 2023/04/01.
//  Copyright © 2023 SOPT-iOS. All rights reserved.
//

import Foundation

public enum ServiceType {
    case officialHomepage
    case review
    case project
    case faq
    case youtube
    case attendance
    case member
    case group
    case instagram
    
    public var serviceDomainLink: String {
        switch self {
        case .officialHomepage: return "https://sopt.org"
        case .review: return "https://sopt.org/review"
        case .project: return "https://playground.sopt.org/projects"
        case .faq: return "https://sopt.org/FAQ"
        case .youtube: return "https://m.youtube.com/@SOPTMEDIA"
        case .attendance: return ""
        case .member: return "https://playground.sopt.org/members"
        case .group: return "https://playground.sopt.org/group?utm_source=playground_group&utm_medium=app_button&utm_campaign=app"
        case .instagram: return "https://www.instagram.com/sopt_official"
        }
    }
}

public enum AppServiceType {
    case soptamp
}
