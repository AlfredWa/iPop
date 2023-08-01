//
//  ContentView.swift
//  iPop
//
//  Created by Alfred on 2023-07-29.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                // 在视图加载时获取用户的位置
                getLocation()
            }
    }
    func getLocation() {
            // 创建一个 Core Location 管理器
            let locationManager = CLLocationManager()
            locationManager.requestWhenInUseAuthorization()

            // 获取当前设备的位置
            if let location = locationManager.location {
                region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
