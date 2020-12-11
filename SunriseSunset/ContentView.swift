//
//  ContentView.swift
//  SunriseSunset
//
//  Created by Zixi Yang on 2020-12-08.
//

import SwiftUI

struct ContentView: View {
    
    // To store the response
    @State private var retrievedData = SunriseResponse()
    
    // To store the address to look up each city's information
    @State private var locationAddress = "https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400"
    
    // selected city
    @State private var city = ""
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                            
                Button(action: {
                    fetchSunriseData()
                }, label: {
                    Text("Get data")
                })
                
                Button(action: {
                    locationAddress = "https://api.sunrise-sunset.org/json?lat=43.650213&lng=-79.404837"
                    fetchSunriseData()
                    city = "Toronto"
                }, label: {
                    Text("Get data for Toronto")
                })
                
                Button(action: {
                    locationAddress = "https://api.sunrise-sunset.org/json?lat=31.26486&lng=121.43865"
                    fetchSunriseData()
                    city = "Shanghai"
                }, label: {
                    Text("Get data for Shanghai")
                })
                
                Button(action: {
                    locationAddress = "https://api.sunrise-sunset.org/json?lat=42.36679&lng=71.05958"
                    fetchSunriseData()
                    city = "Boston"
                }, label: {
                    Text("Get data for Boston")
                })
                
                Button(action: {
                    locationAddress = "https://api.sunrise-sunset.org/json?lat=51.51463&lng=-0.13459"
                    fetchSunriseData()
                    city = "London UK"
                }, label: {
                    Text("Get data for London UK")
                })
                
                Button(action: {
                    locationAddress = "https://api.sunrise-sunset.org/json?lat=40.71380&lng=-74.00581e"
                    fetchSunriseData()
                    city = "New York"
                }, label: {
                    Text("Get data for New York")
                })
                
                Button(action: {
                    locationAddress = "https://api.sunrise-sunset.org/json?lat=48.86194&lng=-235117"
                    fetchSunriseData()
                    city = "Paris"
                }, label: {
                    Text("Get data for Paris")
                })
                
                HStack {
                    Text(city)
                }
                
                HStack {
                    Text("Day length:")
                        .fontWeight(.bold)
                    Spacer()
                    Text(retrievedData.results.day_length)
                }
                .padding()
                
                Spacer()
                HStack {
                    Text("Sunrise Time:")
                        .fontWeight(.bold)
                    Spacer()
//                    Text(retrievedData.results.sunrise_time)
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Sunrise")

        }
        
    }
    
    func fetchSunriseData() {
        
        // 1. Prepare a URLRequest to send our encoded data as JSON
        let url = URL(string: locationAddress)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        // 2. Run the request and process the response
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // handle the result here – attempt to unwrap optional data provided by task
            guard let sunriseData = data else {
                
                // Show the error message
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                
                return
            }
            
            // It seems to have worked? Let's see what we have
            print(String(data: sunriseData, encoding: .utf8)!)
            
            // Now decode from JSON into an array of Swift native data types
            if let decodedSunriseData = try? JSONDecoder().decode(SunriseResponse.self, from: sunriseData) {
                
                print("Sunrise data decoded from JSON successfully")
                print("URL is: \(decodedSunriseData.status)")
                
                // Update on the main thread
                DispatchQueue.main.async {
                    retrievedData = decodedSunriseData
                }
                
            } else {
                
                print("Invalid response from server.")
                
            }
            
        }.resume()
        
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}
