//
//  SecCertificate+PinnedCertificates.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 9/12/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

extension SecCertificate {
    
    /// This asks the bundle to search for all certificates inside of a specififed directory then returns whatever certificates are available
    ///
    ///
    
    public static func certificates(in bundle: Bundle = Bundle.main, in directory: String = "certificates") -> [SecCertificate] {
        var certificates: [SecCertificate] = []
        
        let paths = bundle.paths(forResourcesOfType: "cer", inDirectory: nil)
        for path in paths {
            if
                let certificateData = try? Data(contentsOf: URL(fileURLWithPath: path)) as CFData,
                let certificate = SecCertificateCreateWithData(nil, certificateData)
            {
                certificates.append(certificate)
            }
        }
        
        return certificates
    }
}
