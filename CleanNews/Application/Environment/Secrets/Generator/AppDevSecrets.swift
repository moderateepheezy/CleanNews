enum AppDevSecrets: Secrets {
    private static let salt: [UInt8] = [
        0x0f, 0xae, 0x09, 0x9f, 0x9c, 0x34, 0x32, 0xc1, 
        0x8f, 0x1f, 0x6d, 0x6c, 0x06, 0x22, 0x5d, 0xa5, 
        0x4f, 0xce, 0xb8, 0xca, 0xbd, 0x16, 0x41, 0xe3, 
        0x35, 0xb2, 0x8a, 0x51, 0xaf, 0x09, 0x2c, 0x55, 
        0x8b, 0xd4, 0xb2, 0xcf, 0x77, 0x4e, 0x14, 0x56, 
        0x77, 0x70, 0x5b, 0x50, 0xcb, 0x36, 0xcd, 0x4c, 
        0xcf, 0x4d, 0x5b, 0xbb, 0xe0, 0xdc, 0xb7, 0xba, 
        0x5a, 0x25, 0xcb, 0x27, 0xbf, 0xd3, 0x03, 0x2b, 
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
            0x6c, 0x96, 0x6a, 0xae, 0xff, 0x04, 0x53, 0xf5, 
            0xa2, 0x2c, 0x5c, 0x09, 0x31, 0x0f, 0x69, 0x92, 
            0x2d, 0xfb, 0x95, 0xab, 0x89, 0x27, 0x72, 0xce, 
            0x56, 0x86, 0xbd, 0x61, 0x9a, 0x3e, 0x4e, 0x34, 
            0xbd, 0xb5, 0x85, 0xf8, 
        ]

        return decode(encoded, cipher: salt)
    }
}