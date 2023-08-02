//
//  ContentView.swift
//  iPop
//
//  Created by Alfred on 2023-07-29.
//

import SwiftUI
import MapKit

struct Landmark: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    let landmarks = {
        Landmark(name: "Alfred", coordinate: CLLocationCoordinate2D(latitude: 38, longitude: -77))
    }
    
    
    
    var body: some View {
        Map(
            coordinateRegion: $region,
            showsUserLocation: true
        )
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                // 在视图加载时获取用户的位置
                print("latitude: ", region.center.latitude)
                Task {
                    await getLocation()
                }
                print("latitude after get location: ", region.center.latitude)
                
            }
    }
    func getLocation() async throws -> String{
        // 创建一个 Core Location 管理器
        let locationManager = CLLocationManager()
        
        switch locationManager.authorizationStatus{
        case .authorized:
            print("定位授权已允许")
            locationManager.startUpdatingLocation()
        case .denied:
            print("定位授权已拒绝")
        case .notDetermined:
            print("定位授权尚未决定")
            try await locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
        // 获取当前设备的位置
        if let location = locationManager.location {
            region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            print("in if!!!!!!!!!")
        }
        //locationManager.startUpdatingLocation()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
