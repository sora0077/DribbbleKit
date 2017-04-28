//
//  ListShots.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct ListShots<Shot: ShotData, User: UserData, Team: TeamData>: PaginatorRequest {
    public typealias Element = (shot: Shot, user: User, team: Team?)

    public enum List: String {
        case animated, attachments, debuts, playoffs, rebounds, terms
    }
    public enum Timeframe: String {
        case week, month, year, ever
    }
    public enum Sort {
        case comments(Timeframe?)
        case views(Timeframe?)
        case recent

        var rawValue: String? {
            switch self {
            case .comments: return "comments"
            case .recent: return "recent"
            case .views: return "views"
            }
        }

        var timeframe: Timeframe? {
            switch self {
            case .comments(let timeframe), .views(let timeframe): return timeframe
            default: return nil
            }
        }
    }

    public let path: String
    public let parameters: Any?

    public init(list: List? = nil, date: Date? = nil, sort: Sort? = nil, page: Int? = nil, perPage: Int? = configuration?.perPage) {
        path = "/shots"
        parameters = [
            "list": list?.rawValue,
            "timeframe": sort?.timeframe?.rawValue,
            "sort": sort?.rawValue,
            "date": date.map(ParameterTransformer.date),
            "page": page,
            "per_page": perPage
        ].cleaned
    }

    public init(link: Meta.Link) throws {
        path = link.url.path
        parameters = link.queries
    }

    public func responseElements(from objects: [Any], meta: Meta) throws -> [Element] {
        return try objects.map {
            try (decode($0),
                 decode($0, rootKeyPath: "user"),
                 decode($0, rootKeyPath: "team", optional: true))
        }
    }
}
