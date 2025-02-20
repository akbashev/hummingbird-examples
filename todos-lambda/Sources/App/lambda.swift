//===----------------------------------------------------------------------===//
//
// This source file is part of the Hummingbird server framework project
//
// Copyright (c) 2021-2021 the Hummingbird authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See hummingbird/CONTRIBUTORS.txt for the list of Hummingbird authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import AWSLambdaEvents
import AWSLambdaRuntime
import HummingbirdFoundation
import HummingbirdLambda

@main
public struct AppLambda: HBLambda {
    public typealias Event = APIGatewayRequest
    public typealias Output = APIGatewayResponse

    public init(_ app: HBApplication) throws {
        try app.configure()
    }
}
