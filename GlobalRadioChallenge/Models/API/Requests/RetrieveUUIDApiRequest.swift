//
//  RetrieveUUIDApiRequest.swift
//  GlobalRadioChallenge
//
//  Created by Adam Bella on 10/16/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Alamofire

struct RetrieveUUIDApiRequest: ApiRequestProtocol {

    var urlPath: ApiPath
    let method = HTTPMethod.get

}
