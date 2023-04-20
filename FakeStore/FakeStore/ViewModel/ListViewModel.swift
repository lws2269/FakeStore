//
//  ListViewModel.swift
//  FakeStore
//
//  Created by leewonseok on 2023/04/19.
//

import RxSwift
import RxCocoa

class ListViewModel {
    private let disposeBag = DisposeBag()
    
    let items = BehaviorRelay<[Item]>(value: [])
    let isLoading = BehaviorRelay(value: false)
    let sortState = BehaviorRelay<SortType>(value: .desc)
    let sortList = [SortType.desc.description, SortType.asc.description]
    
    var sortText: Driver<String> {
        // sortState에 따른 Description
        return sortState.map { [weak self] state in
            self?.sortList[state.rawValue] ?? ""
        }.asDriver(onErrorJustReturn: "")
    }
    
    init() {
        fetchItems()
        setupBindings()
    }

    private func fetchItems() {
        isLoading.accept(true)
        
        NetworkManager.fetchItemAllRx(urlString: Constants.URL)
            .subscribe(onNext: { [weak self] items in
                self?.items.accept(items)
                self?.isLoading.accept(false)
            }, onError: { error in
                print("Error: \(error.localizedDescription)")
                self.isLoading.accept(false)
            })
            .disposed(by: disposeBag)
    }

    private func setupBindings() {
        // sortState이 변경되면 items를 정렬
        sortState
            .subscribe(onNext: { [weak self] sortType in
                guard let items = self?.items.value else { return }
                if let sortedItems = self?.sortedItems(items: items, sortType: sortType) {
                    self?.items.accept(sortedItems)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func sortedItems(items: [Item], sortType: SortType) -> [Item] {
        switch sortType {
        case .desc:
            return items.sorted { $0.id < $1.id }
        case .asc:
            return items.sorted { $0.id > $1.id }
        }
    }
}
