//
//  UIDevice+Extension.swift
//  CleanNews
//
//  Created by Afees Lawal on 03/01/2022.
//

import DeviceGuru
import UIKit

extension UIDevice {
    static var isSmallScreen: Bool {
        [Hardware.iphone_se, .iphone_se_2g, .ipod_touch_1g,
         .ipod_touch_2g, .ipod_touch_3g, .ipod_touch_4g,
         .ipod_touch_5g, .ipod_touch_6g, .ipod_touch_7g,
         .iphone_12_mini, .iphone_13_mini, .iphone_6,
         .iphone_6_plus, .iphone_6s_plus, .iphone_6s,
         .iphone_7, .iphone_7_gsm, .iphone_7_plus,
         .iphone_7_plus_gsm, .iphone_8, .iphone_8_cn,
         .iphone_8_plus, .iphone_8_plus_cn,
         .iphone_8_plus_cn]
            .contains(DeviceGuru().hardware())
    }
}
