enum AppProdSecrets: Secrets {
    private static let salt: [UInt8] = [
        0xd1, 0x3e, 0xd4, 0xa9, 0xb1, 0x5f, 0x87, 0x32, 
        0xb3, 0xbc, 0x1f, 0xbc, 0x39, 0xd9, 0x2b, 0xb0, 
        0x96, 0x9b, 0x66, 0xdd, 0xb5, 0x61, 0x51, 0xb6, 
        0xcc, 0xe7, 0x09, 0x60, 0x1f, 0x84, 0xda, 0xed, 
        0x4d, 0x81, 0x3a, 0x6a, 0xfa, 0x82, 0x35, 0x3d, 
        0xba, 0xc0, 0xb5, 0x43, 0x4f, 0x81, 0x9d, 0xa2, 
        0xef, 0x56, 0x88, 0xb4, 0x19, 0xf9, 0x2f, 0xec, 
        0xc1, 0x93, 0x43, 0x9c, 0x18, 0x64, 0xf7, 0x8b, 
    ]

    private static func decode(_ encoded: [UInt8], cipher: [UInt8]) -> String {
        String(
            decoding: encoded.enumerated().map { offset, element in
                element ^ cipher[offset % cipher.count]
            },
            as: UTF8.self)
    }

    static var apiKey: String {
        let encoded: [UInt8] = [
            0xb2, 0x06, 0xb7, 0x98, 0xd2, 0x6f, 0xe6, 0x06, 
            0x9e, 0x8f, 0x2e, 0xd9, 0x0e, 0xf4, 0x1f, 0x87, 
            0xf4, 0xae, 0x4b, 0xbc, 0x81, 0x50, 0x62, 0x9b, 
            0xaf, 0xd3, 0x3e, 0x50, 0x2a, 0xb3, 0xb8, 0x8c, 
            0x7b, 0xe0, 0x0d, 0x5d, 
        ]

        return decode(encoded, cipher: salt)
    }
}
