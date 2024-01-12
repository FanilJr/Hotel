//
//  Network.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 11.01.2024.
//

import Foundation

class Network {
    static var shared = Network()
    private init() {}
    
    func getHotel(completion: @escaping ((_ hotel: Hotel) -> Void), completionError: @escaping ((_ error: String) -> Void)) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: URL(string: "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473")!) { data, responce, error in
            if let error {
                completionError(error.localizedDescription)
                return
            }
            if (responce as? HTTPURLResponse)?.statusCode != 200 {
                completionError(String(describing: (responce as? HTTPURLResponse)?.statusCode))
                return
            }
            guard let data else {
                print("data = nil")
                return
            }
            do {
                let hotel = try JSONDecoder().decode(Hotel.self, from: data)
                completion(hotel)
            } catch {
                completionError(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getRooms(completion: @escaping ((_ room: Rooms) -> Void), completionError: @escaping ((_ error: Error) -> Void)) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: URL(string: "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195")!) { data, responce, error in
            if let error {
                completionError(error)
                return
            }
            if (responce as? HTTPURLResponse)?.statusCode != 200 {
                return
            }
            guard let data else {
                print("data = nil")
                return
            }
            do {
                let rooms = try JSONDecoder().decode(Rooms.self, from: data)
                completion(rooms)
            } catch {
                completionError(error)
            }
        }
        task.resume()
    }
    
    func getReservation(completion: @escaping ((_ reserv: Reserv) -> Void), completionError: @escaping ((_ error: Error) -> Void)) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: URL(string: "https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff")!) { data, responce, error in
            if let error {
                completionError(error)
                return
            }
            if (responce as? HTTPURLResponse)?.statusCode != 200 {
                return
            }
            guard let data else {
                print("data = nil")
                return
            }
            do {
                let reserv = try JSONDecoder().decode(Reserv.self, from: data)
                completion(reserv)
            } catch {
                completionError(error)
            }
        }
        task.resume()
    }
}
