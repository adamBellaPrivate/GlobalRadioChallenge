//
//  RetrieveUUIDApiResponse.swift
//  GlobalRadioChallenge
//
//  Created by Adam Bella on 10/16/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

struct RetrieveUUIDApiResponse: Decodable {

    let path: String
    let responseCode: String

    private enum CodingKeys: String, CodingKey {
        case path
        case responseCode = "response_code"
    }

}
