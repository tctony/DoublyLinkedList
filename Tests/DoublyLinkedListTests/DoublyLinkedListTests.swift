import XCTest
@testable import DoublyLinkedList

final class DoublyLinkedListTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testInsert() {
        var list = DoublyLinkedList<Int>()
        list.insert(1)
        list.insert(2)
        list.insert(3)
        print(Array(list))
        XCTAssertEqual(Array(list), [3, 2, 1])
    }

    func testInsertBefore() {
        var list = DoublyLinkedList<Int>()
        let first = list.insert(1, before: nil)
        list.insert(2, before: nil)
        list.insert(3, before: first)
        print(Array(list))
        XCTAssertEqual(Array(list), [2, 3, 1])
    }

    func testInsertAfter() {
        var list = DoublyLinkedList<Int>()
        let first = list.insert(1, after: nil)
        list.insert(2, after: nil)
        list.insert(3, after: first)
        print(Array(list))
        XCTAssertEqual(Array(list), [1, 3, 2])
    }

    func testRemove() {
        var list = DoublyLinkedList<Int>()
        let first = list.insert(1, after: nil)
        let second =  list.insert(2, after: nil)
        let third = list.insert(3, after: nil)
        print(Array(list))
        XCTAssertEqual(Array(list), [1, 2, 3])
        list.remove(second)
        XCTAssertEqual(Array(list), [1, 3])
        list.remove(third)
        XCTAssertEqual(Array(list), [1])
        list.remove(first)
        XCTAssertEqual(Array(list), [])
    }

    static var allTests = [
        ("testInsert", testInsert),
        ("testInsertBefore", testInsertBefore),
        ("testInsertAfter", testInsertAfter),
        ("testRemove", testRemove),
    ]
}
