//
//  sunrise.swift
//  SunriseSunset
//
//  Created by Zixi Yang on 2020-12-09.
//

import Foundation

struct Sunrise: Codable {
    var sunrise: String = ""
    var sunset: String = ""
    var solar_noon: String = ""
    var day_length: String = ""
    var civil_twilight_begin: String = ""
    var civil_twilight_end: String = ""
    var nautical_twilight_begin: String = ""
    var nautical_twilight_end: String = ""
    var astronomical_twilight_begin: String = ""
    var astronomical_twilight_end: String = ""
}

struct SunriseResponse: Codable {
    var results: Sunrise = Sunrise()
    var status: String = ""
}
