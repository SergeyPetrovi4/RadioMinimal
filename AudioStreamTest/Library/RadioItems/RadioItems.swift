//
//  RadioItems.swift
//  AudioStreamTest
//
//  Created by Sergey Krasiuk on 13/03/2020.
//  Copyright © 2020 Sergey Krasiuk. All rights reserved.
//

import Foundation

enum RadioURL: String {
    case rrDrumAndBass = "http://air2.radiorecord.ru:9003/drumhits_320"
    case dfmPopDance = "https://dfm-popdance.hostingradio.ru/popdance96.aacp"
    case dfmRussianDance = "https://dfm-dfmrusdance.hostingradio.ru/dfmrusdance96.aacp"
    case rrRussianGold = "http://air2.radiorecord.ru:9003/russiangold_320"
    case dnbMyRadio = "http://relay.myradio.ua:8000/DrumAndBass128.mp3"
    case countryRadio = "https://live.leanstream.co/CKRYFM"
    case americasCountry = "https://ais-sa2.cdnstream1.com/1976_128.mp3"
    case batYamRadioRus = "http://891fm.streamgates.net/891Fm"
    case rrRussianHits = "http://air2.radiorecord.ru:9003/russianhits_320"
    case rrEDMHits = "http://air2.radiorecord.ru:9003/edmhits_320"
    case rrFutureHouse = "http://air2.radiorecord.ru:9003/fut_320"
    
}

struct RadioItems {
   static let values: [RadioItem] = {
        return [
            RadioItem(title: "Radio Record Drum'n'Bass", streamURL: .rrDrumAndBass, imageName: "radioRecord"),
            RadioItem(title: "DFM Pop Dance", streamURL: .dfmPopDance, imageName: "dfmPopDance"),
            RadioItem(title: "DFM Russian Dance", streamURL: .dfmRussianDance, imageName: "russianDance"),
            RadioItem(title: "Radio Records Russian Hits", streamURL: .rrRussianHits, imageName: "rrRussianHits"),
            RadioItem(title: "Radio Records EDM Hits", streamURL: .rrEDMHits, imageName: "rrEdmHits"),
            RadioItem(title: "Bat Yam 89.1 FM", streamURL: .batYamRadioRus, imageName: "batYamRussian"),
            RadioItem(title: "Radio Records Russian Gold", streamURL: .rrRussianGold, imageName: "rrRussianGold"),
            RadioItem(title: "DnB My Radio", streamURL: .dnbMyRadio, imageName: "dnbMyRadio"),
            RadioItem(title: "Country 105 FM", streamURL: .countryRadio, imageName: "countryRadio"),
            RadioItem(title: "Americas Country", streamURL: .americasCountry, imageName: "americasCountry"),
            RadioItem(title: "Radio Record Future House", streamURL: .rrFutureHouse, imageName: "rrFutureHouse")
        ]
    }()
}


