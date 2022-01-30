enum AppDevSecrets: Secrets {
    private static let salt: [UInt8] = [
        0xce, 0x90, 0xe4, 0x7f, 0x28, 0x1e, 0xb3, 0xaa, 
        0xc5, 0x6f, 0x8b, 0x31, 0x83, 0x26, 0xd7, 0x54, 
        0x4f, 0x88, 0xf3, 0x67, 0x3d, 0x12, 0x3b, 0xff, 
        0x86, 0x48, 0xc8, 0x2e, 0x4b, 0x25, 0x6e, 0x3b, 
        0x2b, 0xcd, 0xef, 0x43, 0xea, 0xfe, 0x31, 0x52, 
        0x16, 0x39, 0x99, 0x30, 0x29, 0x13, 0xf6, 0x84, 
        0x07, 0x42, 0x6d, 0x31, 0x4d, 0x47, 0xaf, 0x94, 
        0xfb, 0x75, 0xe8, 0x61, 0x16, 0x62, 0xc1, 0x7f, 
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
            0xad, 0xa8, 0x87, 0x4e, 0x4b, 0x2e, 0xd2, 0x9e, 
            0xe8, 0x5c, 0xba, 0x54, 0xb4, 0x0b, 0xe3, 0x63, 
            0x2d, 0xbd, 0xde, 0x06, 0x09, 0x23, 0x08, 0xd2, 
            0xe5, 0x7c, 0xff, 0x1e, 0x7e, 0x12, 0x0c, 0x5a, 
            0x1d, 0xac, 0xd8, 0x74, 
        ]

        return decode(encoded, cipher: salt)
    }
}
