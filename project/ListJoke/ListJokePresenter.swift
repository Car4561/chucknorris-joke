//
//  ListPresenter.swift
//  project
//
//  Created by carlos alfredo llerena huayta on 23.02.22.
//

import Foundation
import Alamofire

class ListJokePresenter {
    
    var view: ListJokeView?
    
    var jokes: [Joke] = []
    var jokesId: [String] = []

    
    init(view: ListJokeView) {
        self.view = view
    }
    
    func onViewDidLoad(){
        fetchJoke()
    }
    
    func fetchJoke(){
        let semaphore = DispatchSemaphore(value: 0)
        let dispatchGroup = DispatchGroup()
                 
            var N = 14
            for i in 0...N{
                dispatchGroup.enter()
                self.request(url: "https://api.chucknorris.io/jokes/random", method: .get){ result in

                switch(result){
                case .failure(let error):
                    print(error)
                case .success(let response):

                    guard let json = response as? [String:Any] else {
                        return
                    }
                    
                        let joke = Joke(id: json["id"] as! String, title: json["value"] as! String, icon: json["icon_url"] as! String)
                        
                        if !self.jokesId.contains(joke.id) {
                            self.jokes.append(joke)
                            self.jokesId.append(joke.id)
                        }else{
                            N += 1
                        }
                       //semaphore.signal()
                        dispatchGroup.leave()
                }

            }

           //semaphore.wait()

        }
        dispatchGroup.notify(queue: .main) {
            self.makeViewModel()
        }
      
        
    }
    
    func request(url: String, method: HTTPMethod, parameters: [String: Any]? = nil, completion: @escaping (Result<Any, Error>) -> Void){
        AF.request(url,
                   method: method,
                                            parameters: parameters,
                                            encoding: JSONEncoding.default )
                                     .validate(contentType: ["application/json"])
                     .responseJSON { response in
                         switch response.result {
                         case .success:
                            completion(.success(response.value))
                            

                         case .failure: break
                            completion(.failure(response.error as! Error))
              }
          }
    }
    
    
    
    func makeViewModel() {
        //let jokes = [Joke(id: "1", title: "MEME 1", icon: "prueba"), Joke(id: "1", title: "MEME 1", icon: "prueba"), Joke(id: "1", title: "MEME 1", icon: "prueba"), Joke(id: "1", title: "MEME 1", icon: "prueba")]
        
        let cells =  self.jokes.map{ makeCell(joke: $0)}
        view?.viewModel = ListJokeViewModel(cells: cells)
    }
    
    func makeCell(joke: Joke) -> ListJokeViewModel.JokeCell {
        return ListJokeViewModel.JokeCell(title: joke.title, icon: joke.icon)
    }
    
}
