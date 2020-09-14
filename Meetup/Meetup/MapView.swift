//
//  MapView.swift
//  Meetup
//
//  Created by Japneet Singh on /149/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    @State var image: ImageData

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.cameraZoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 2000)
        mapView.centerCoordinate = self.image.coordinate 
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let date = formatter.string(from: image.date)
        let annotation = MKPointAnnotation()
        annotation.title = image.meetup
        annotation.subtitle = date
        annotation.coordinate = self.image.coordinate
        mapView.addAnnotation(annotation)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate, UINavigationControllerDelegate{
        
        var parent: MapView
        
        init(_ parent: MapView){
            self.parent = parent
        }
    }
    
}

