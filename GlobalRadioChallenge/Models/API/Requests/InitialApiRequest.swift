//
//  InitialApiRequest.swift
//  GlobalRadioChallenge
//
//  Created by Adam Bella on 10/16/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Alamofire

struct InitialApiRequest: ApiRequestProtocol {

    var urlPath: ApiPath = .initial
    let method = HTTPMethod.get
}
