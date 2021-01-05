import Foundation

public struct DoublyLinkedList<T>: Sequence {

    public class Node {
        public var value: T

        var pre: Node?
        var next: Node?

        public init(value: T) {
            self.value = value
        }
    }

    public struct Iterator: IteratorProtocol {

        var current: Node?

        init(_ node: Node?) {
            self.current = node
        }

        public mutating func next() -> T? {
            if let node = self.current {
                self.current = self.current!.next
                return node.value
            }
            return nil
        }
    }

    // MARK: -

    public init() {
        // do nothing
    }

    public __consuming func makeIterator() -> Iterator {
        return Iterator(self.head)
    }

    // MARK: -

    private var head: Node?
    private var tail: Node?

    @discardableResult
    private mutating func insertBetween(_ node: Node, left: Node?, right: Node?) -> Node {
        if left == nil && right == nil {
            precondition(self.head == nil && self.tail == nil)

            self.head = node
            self.tail = node

        } else if left == nil {
            precondition(self.head != nil && self.head! === right!)

            node.pre = nil
            node.next = self.head

            self.head!.pre = node

            self.head = node

        } else if right == nil {
            precondition(self.tail != nil && self.tail! === left!)

            node.pre = self.tail!
            node.next = nil

            self.tail!.next = node

            self.tail = node
        } else {
            left!.next = node

            node.pre = left!
            node.next = right!

            right!.pre = node
        }

        return node
    }

    @discardableResult
    public mutating func insert(_ val: T) -> Node {
        let node = Node(value: val)
        return self.insert(node, before: self.head)
    }
    @discardableResult
    public mutating func insert(_ node: Node) -> Node {
        return self.insert(node, before: self.head)
    }

    @discardableResult
    public mutating func insert(_ val: T, before: Node?) -> Node {
        let node = Node(value: val)
        return self.insert(node, before: before)
    }
    @discardableResult
    public mutating func insert(_ node: Node, before: Node?) -> Node {
        if before != nil {
            return self.insertBetween(node, left: before!.pre, right: before)
        } else {
            return self.insertBetween(node, left: head?.pre, right: head)
        }
    }

    @discardableResult
    public mutating func insert(_ val: T, after: Node?) -> Node {
            let node = Node(value: val)
            return self.insert(node, after: after)
    }
    @discardableResult
    public mutating func insert(_ node: Node, after: Node?) -> Node {
        if after != nil {
            return self.insertBetween(node, left: after!, right: after!.next)
        } else {
            return self.insertBetween(node, left: tail, right: tail?.next)
        }
    }

    @discardableResult
    public mutating func remove(_ node: Node) -> Node {
        let left = node.pre
        let right = node.next

        if left == nil && right == nil {
            self.head = nil
            self.tail = nil
        } else if left == nil {
            right!.pre = nil
            self.head = right!
        } else if right == nil {
            left!.next = nil
            self.tail = left
        } else {
            left!.next = right
            right!.pre = left
        }

        return node
    }

    @discardableResult
    public mutating func removeHead() -> Node? {
        if self.head != nil {
            return self.remove(self.head!)
        } else {
            return nil
        }
    }

    @discardableResult
    public mutating func removeTail() -> Node? {
        if self.tail != nil {
            return self.remove(self.tail!)
        } else {
            return nil
        }
    }
}
