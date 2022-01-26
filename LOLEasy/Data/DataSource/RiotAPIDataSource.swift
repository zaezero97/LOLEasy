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
    func fetchSummoner(id: String) -> Single<SummonerResponseDTO>
//    func fetchSummonerIcon(iconId: Int) -> Single<Data>
//    func fetchSummonerTier(id: String) -> Single<[SummonerTier]>
}

final class DefaultRiotAPIDataSource: RiotAPIDataSource {
    func fetchSummoner(id: String) -> Single<SummonerResponseDTO> {
        return Single<SummonerResponseDTO>.create {
            observer -> Disposable in
            
            let headers: HTTPHeaders = [
                "Content-Type":"application/json;charset=utf-8",
                "Accept-Language": "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7,zh-CN;q=0.6,zh;q=0.5",
                "Origin": "https://developer.riotgames.com",
            ]
            
            let parameters = SummonerRequestDTO(api_key: App.RiotToken)
            
            let request = AF.request(
                URL.SUMMONER_V4(id:id.replacingOccurrences(of: " ", with: "").addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!),
                method: .get,
                parameters: parameters,
                headers: headers
            ).responseDecodable(of: SummonerResponseDTO.self ) { response in
                switch response.result {
                case .success(let summonerResponseDTO):
                    observer(.success(summonerResponseDTO))
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
