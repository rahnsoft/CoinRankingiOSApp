
import Foundation

protocol BaseDataModel {
    associatedtype Model
    func toDomainModel() -> Model
}
