# Testing Data Define with Protocol
[Defining Test Data in Swift](https://www.swiftbysundell.com/articles/defining-testing-data-in-swift/)를 통해 어떻게 Test용 데이터를 효율적으로 만들 수 있을지 알아본다.

## 전형적인 DataTest

```Swift
    func testAddPerson() throws {
        sut = People()
        
        let person0 = Person(
            id: "Park",
            name: "kim",
            address: Address(nation: "korea"),
            family: []
        )
        
        XCTAssertFalse(sut.people.contains(person0))
        
        sut.addPerson(person: person0)
        
        XCTAssertTrue(sut.people.contains(person0))
    }
```
### 문제점 
- 만약, person객체를 아주 많이 만들어야 할 경우 코드가 상당히 길어짐.
- 좀더, 복잡한 로직을 가지게 될 경우 Stub를 만드는 코드에 가려져서 핵심 로직을 바로 보고 이해하기 힘듬.

### 해결책
- Helper Method를 만든다.
```swift
extension PersonDataTest {
    func makePerson(withID: String, count: Int) -> [Person] {
        return (0..<count).map { index in
            Person(
                id: Identifier(rawValue: "\(index)"),
                name: "Kime",
                address: Address(nation: "Japan"),
                family: []
            )
        }
    }
}
```

- Protocol을 이용한다.
```Swift
protocol Identifiable {
    associatedtype RawIdentifier: Codable & Hashable = String

    var id: Identifier<Self> { get }
}

struct Identifier<Value: Identifiable> {
    
    let rawValue: Value.RawIdentifier
    
    init(rawValue: Value.RawIdentifier) {
        self.rawValue = rawValue
    }
}
```

```Swift

protocol Stubbable: Identifiable {
    static func stub(with id: Identifier<Self>) -> Self
}

extension Stubbable {
    func setting<T>(_ keyPath: WritableKeyPath<Self, T>, to value: T) -> Self {
        var stub = self
        stub[keyPath: keyPath] = value
        return stub
    }
}
```

### 장 단점.
|방법|HelperMethod|Protocol|
|:----|:----|:----|
| 장점 | 비교적 `구현하기 간단`함 </br> Test하는 함수내에서 불필요한 보일러플레이트 코드 줄임.| `재사용성 있는` Test용 데이터만드는 함수를 제작 가능.|
| 단점 | 코드를 생성하는 코드가 `매번 추가` 될 수 있음.</br>(재사용성이 부족하다)| 설계 및 구현하기 쉽지 않음. </br> 간단한 데이터만 있을경우 `Over engineering`이 될수있음.|

### 실제 구현 모습
```Swift
    func testAddPerson() throws {
        sut = People()
        let person0 = Person
            .stub(with: "Park")
            .setting(\.address, to: Address(nation: "U.S.A"))
        
        XCTAssertFalse(sut.people.contains(person0))
        
        sut.addPerson(person: person0)
        XCTAssertTrue(sut.people.contains(person0))
    }

```
