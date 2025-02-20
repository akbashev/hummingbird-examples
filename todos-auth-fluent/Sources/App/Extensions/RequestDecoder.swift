//===----------------------------------------------------------------------===//
//
// This source file is part of the Hummingbird server framework project
//
// Copyright (c) 2021-2023 the Hummingbird authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See hummingbird/CONTRIBUTORS.txt for the list of Hummingbird authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import Hummingbird
import HummingbirdFoundation

/// Request body decoder
struct RequestDecoder: HBRequestDecoder {
    func decode<T>(_ type: T.Type, from request: HBRequest) throws -> T where T: Decodable {
        /// if no content-type header exists or it is an unknown content-type return bad request
        guard let header = request.headers["content-type"].first else { throw HBHTTPError(.badRequest) }
        guard let mediaType = HBMediaType(from: header) else { throw HBHTTPError(.badRequest) }
        switch mediaType {
        case .applicationJson:
            return try JSONDecoder().decode(type, from: request)
        case .applicationUrlEncoded:
            return try URLEncodedFormDecoder().decode(type, from: request)
        default:
            throw HBHTTPError(.badRequest)
        }
    }
}
