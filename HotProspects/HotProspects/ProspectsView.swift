//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Andres Vazquez on 2020-09-01.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var showingSortingOptions = false
    let filter: FilterType
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    var sampleScanData: String {
        let names = ["John Smith", "Sam Brown", "Jessica Gonzalez", "Amy Jones", "Rose Williams"]
        let emails = ["john@smith.com", "sam@brown.com", "jessica@gonzalez.com", "amy@jones.com", "rose@williams.com"]
        let index = Int.random(in: 0..<names.count)
        
        return "\(names[index])\n\(emails[index])"
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        Image(systemName: prospect.isContacted ? "checkmark.circle" : "xmark.circle")
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.email)
                                .foregroundColor(.secondary)
                        }
                        .contextMenu {
                            Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted" ) {
                                self.prospects.toggle(prospect)
                            }
                            
                            if !prospect.isContacted {
                                Button("Remind Me") {
                                    self.addNotification(for: prospect)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(
                leading: Button(action: {
                    self.showingSortingOptions = true
                }) {
                    Text("Sort")
                    Image(systemName: "arrow.up.arrow.down.circle")
                },
                trailing: Button(action: {
                    self.isShowingScanner = true
                }) {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                }
            )
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: self.sampleScanData, completion: self.handleScan)
            }
            .actionSheet(isPresented: $showingSortingOptions) {
                ActionSheet(title: Text("Sort by:"), message: nil, buttons: [
                    .default(Text("Name")) {
                        self.prospects.sort(by: .name)
                    },
                    .default(Text("Creation date")) {
                        self.prospects.sort(by: .creationDate)
                    },
                    .cancel()
                ])
            }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.email = details[1]
            self.prospects.add(person)
            
        case .failure(_):
            print("Scanning failed")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.email
            content.sound = UNNotificationSound.default
            
//            var date = DateComponents()
//            date.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
                    if success {
                        addRequest()
                    } else {
                        print("Can't send notifications")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
