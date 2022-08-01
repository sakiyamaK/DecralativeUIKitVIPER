import Foundation

typealias GithubListEntity = GithubModel

struct GithubListResponse: Codable {
    let items: [GithubListEntity]
}
