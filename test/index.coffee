assert = require "assert"

OrderedMap = require "../src/index.coffee"

describe "OrderedMap()", ->
  it "is a function", ->
    assert.equal typeof OrderedMap, "function"

  it "can could be called with `new` I guess", ->
    ordered_map = new OrderedMap()
    assert.equal ordered_map instanceof OrderedMap, false

  it "can be called without `new`, and without global side effects, because duh", ->
    num_globals = Object.keys(global).length
    ordered_map = OrderedMap()
    assert.equal num_globals, Object.keys(global).length

describe "Methods", ->
  instance = undefined
  beforeEach ->
    instance = OrderedMap()

  describe "#push", ->
    it "is a function", ->
      assert.equal typeof instance.push, "function"

    it "adds a key-value pair to the tail", ->
      instance.push "ABC", "DEF"
      assert.equal instance.size(), 1
      assert.equal instance.tail().key, "ABC"
      assert.equal instance.tail().value, "DEF"
      instance.push "GHI", "JKL"
      assert.equal instance.size(), 2
      assert.equal instance.tail().key, "GHI"
      assert.equal instance.tail().value, "JKL"

    it "wires up .next properly", ->
      instance.push "ABC", "DEF"
      prior_tail = instance.tail()
      instance.push "GHI", "JKL"
      assert.equal instance.tail().prev, prior_tail
      
    it "adds the pair at the head if no head existed previously", ->
      instance.push "ABC", "DEF"
      assert.equal instance.head(), instance.tail()

  describe "#pop", ->
    it "is a function", ->
      assert.equal typeof instance.pop, "function"

    it "removes a key value pair from the tail", ->
      instance.push 'abc', 'def'
      instance.push 'ghi', 'jkl'

      assert.equal instance.size(), 2
      assert.equal instance.head().key, 'abc'
      assert.equal instance.head().value, 'def'

      popped = instance.pop()

      assert.equal popped, 'jkl'
      assert.equal instance.size(), 1
      assert.equal instance.head().key, 'abc'
      assert.equal instance.head().value, 'def'

      popped = instance.pop()

      assert.equal instance.size(), 0
      assert.equal popped, 'def'

  describe "#shift", ->
    it "is a function", ->
      assert.equal typeof instance.shift, "function"

    it "removes a key-value pair from the head", ->
      instance.push 'abc', 'def'
      instance.push 'ghi', 'jkl'

      assert.equal instance.size(), 2
      assert.equal instance.head().key, 'abc'
      assert.equal instance.head().value, 'def'

      shifted = instance.shift()

      assert.equal shifted, 'def'
      assert.equal instance.size(), 1
      assert.equal instance.head().key, 'ghi'
      assert.equal instance.head().value, 'jkl'

      shifted = instance.shift()

      assert.equal instance.size(), 0
      assert.equal shifted, 'jkl'

  describe "#unshift", ->
    it "is a function", ->
      assert.equal typeof instance.unshift, "function"

    it "adds a key-value pair as the head", ->
      instance.unshift 'abc', 'def'
      assert.equal instance.size(), 1
      assert.equal instance.head().key, 'abc'
      assert.equal instance.head().value, 'def'
      instance.unshift 'ghi', 'jkl'
      assert.equal instance.size(), 2
      assert.equal instance.head().key, 'ghi'
      assert.equal instance.head().value, 'jkl'
  
    it 'wires up .next properly', ->
      instance.unshift 'abc', 'def'
      prior_head = instance.head()
      instance.unshift 'ghi', 'jkl'
      assert.equal instance.head().next, prior_head

    it 'adds the pair as the tail if no tail existed previously', ->
      instance.unshift 'abc', 'def'
      assert.equal instance.head(), instance.tail()


  describe "#get", ->
    it "is a function", ->
      assert.equal typeof instance.get, "function"

    it "retrieves a value by key", ->
      instance.push 'a', 'b'
      instance.push 'c', 'd'
      instance.push 'e', 'f'
      assert.equal instance.get('c'), 'd'

  describe "#remove", ->
    it "is a function", ->
      assert.equal typeof instance.remove, "function"

    it "removes a value by key, and rewires the remaining items", ->
      instance.push 'a', 'b'
      instance.push 'c', 'd'
      instance.push 'e', 'f'
      assert.equal instance.size(), 3

      value = instance.remove 'c'
      assert.equal instance.size(), 2
      assert.equal value, 'd'

      head = instance.head()
      tail = instance.tail()

      assert.equal head.next.value, tail.value
      assert.equal tail.prev.value, head.value

      value = instance.remove 'a'
      assert.equal value, 'b'
      assert.equal instance.size(), 1

      tail = instance.tail()
      head = instance.head()

      assert.equal head, tail

  describe "#keys", ->
    it "is a function", ->
      assert.equal typeof instance.keys, "function"


  describe "#forEach", ->
    it "is a function", ->
      assert.equal typeof instance.forEach, "function"

  describe "#size", ->
    it "is a function", ->
      assert.equal typeof instance.size, "function"

  describe "#head", ->
    it "is a function", ->
      assert.equal typeof instance.head, "function"

  describe "#tail", ->
    it "is a function", ->
      assert.equal typeof instance.tail, "function"