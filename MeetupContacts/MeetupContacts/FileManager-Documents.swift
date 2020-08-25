//
//  FileManager-Documents.swift
//  MeetupContacts
//
//  Created by Andres Vazquez on 2020-08-24.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import Foundation

extension FileManager {
    func getDocument(_ filename: String) -> Data? {
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        do {
            if FileManager.default.fileExists(atPath: url.path) {
                return try Data(contentsOf: url)
            }
            
            return nil
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func saveDocument(_ filename: String, with data: Data, options: Data.WritingOptions) {
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        
        do {
            try data.write(to: url, options: options)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        return self.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
