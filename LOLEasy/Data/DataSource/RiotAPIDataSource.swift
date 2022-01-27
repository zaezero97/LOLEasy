//
//  RiotAPIDataSource.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/26.
//

import Foundation
import RxSwift
import Alamofire



protocol RiotAPIDataSource {
    func fetchSummoner(id: String) -> Observable<Result<
        SummonerResponseDTO,URLError>>
    func fetchLeagueEntry(id: String) -> Single<[LeagueEntryResponseDTO]>
//    func fetchSummonerIcon(iconId: Int) -> Single<Data>
}

final class DefaultRiotAPIDataSource: RiotAPIDataSource {
    private let session: URLSession
    private let riotAPI: RiotAPI
    private let headers: HTTPHeaders = [
        "Content-Type":"application/json;charset=utf-8",
        "Accept-Language": "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7,zh-CN;q=0.6,zh;q=0.5",
        "Origin": "https://developer.riotgames.com"
    ]
    
    init(
        session: URLSession = .shared,
        riotAPI: RiotAPI = RiotAPI()
    ) {
        self.session = session
        self.riotAPI = riotAPI
    }
    func fetchSummoner(id: String) -> Observable<Result<
        SummonerResponseDTO,URLError>> {
            guard let url = self.riotAPI.getSummonerV4URL(id: id).url else {
                return .just(.failure(URLError(.badURL)))
            }
                        
           
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            print(url)
            return self.session.rx.data(request: request)
                .map {
                    data in
                    print(data)
                    do {
                        let summonerResopnseDTO = try JSONDecoder().decode(SummonerResponseDTO.self, from: data)
                        
                        return .success(summonerResopnseDTO)
                    } catch {
                        return .failure(URLError(.cannotParseResponse))
                    }
                }
                .catch{ _ in .just(Result.failure(URLError(.cannotLoadFromNetwork)))}
            
    }
    
    func fetchLeagueEntry(id: String) -> Single<[LeagueEntryResponseDTO]> {
        return Single<[LeagueEntryResponseDTO]>.create {
            [weak self] observer -> Disposable in
            
            let parameters = LeagueEntryRequestDTO(api_key: App.RiotToken)
            let request = AF.request(URL.LEAGUE_V4(id: id), parameters: parameters, headers: self?.headers)
                .responseDecodable(of: [LeagueEntryResponseDTO].self) { response in
                    switch response.result {
                    case .success(let leagueEntryResponseDTOs):
                        observer(.success(leagueEntryResponseDTOs))
                    case .failure(let error):
                        observer(.failure(error))
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
