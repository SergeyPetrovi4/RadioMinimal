//
//  RadioItems.swift
//  AudioStreamTest
//
//  Created by Sergey Krasiuk on 13/03/2020.
//  Copyright © 2020 Sergey Krasiuk. All rights reserved.
//

import Foundation

enum RadioURL: String {
    case dnbRadioRecord = "http://air2.radiorecord.ru:9003/ps_320"
    case dfmPopDance = "https://dfm-popdance.hostingradio.ru/popdance96.aacp"
    case dfmRussianDance = "https://dfm-dfmrusdance.hostingradio.ru/dfmrusdance96.aacp"
    case dnbAtmospheric = "http://brokenbeats.net:8000/tune"
    case dnbMyRadio = "http://relay.myradio.ua:8000/DrumAndBass128.mp3"
    case countryRadio = "https://22113.live.streamtheworld.com/WUSZFMAAC.aac"
    case americasCountry = "https://ais-sa2.cdnstream1.com/1976_128.mp3"
}

struct RadioItems {
   static let values: [RadioItem] = {
        return [
            RadioItem(title: "DnB Radio Record", streamURL: .dnbRadioRecord, imageName: "radioRecord"),
            RadioItem(title: "DFM Pop Dance", streamURL: .dfmPopDance, imageName: "dfmPopDance"),
            RadioItem(title: "DFM Russian Dance", streamURL: .dfmRussianDance, imageName: "russianDance"),
            RadioItem(title: "DnB Atmospheric", streamURL: .dnbAtmospheric, imageName: "dnbAtmospheric"),
            RadioItem(title: "DnB My Radio", streamURL: .dnbMyRadio, imageName: "dnbMyRadio"),
            RadioItem(title: "Country Radio", streamURL: .countryRadio, imageName: "countryRadio"),
            RadioItem(title: "Americas Country", streamURL: .americasCountry, imageName: "americasCountry")
        ]
    }()
}
