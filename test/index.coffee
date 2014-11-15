assert = require "assert"

OrderedMap = require "../src/index.coffee"

describe "OrderedMap()", ->
  it "is a function", ->
    assert.equal typeof OrderedMap, "function"

  it "can could be called with `new` I guess, but don't expect `instanceof` coherence", ->
    instance = new OrderedMap()
    assert.equal instance instanceof OrderedMap, false

  it "can be called without `new`, and without exposing globals, because JS", ->
    num_globals = Object.keys(global).length
    instance = OrderedMap()
    assert.equal num_globals, Object.keys(global).length

describe "Methods", ->
  instance = undefined

  beforeEach ->
    instance = OrderedMap()

  describe "#push", ->
    it "is a function", ->
      assert.equal typeof instance.push, "function"

    it "adds a key-value pair to the tail", ->
      instance.push 'abc', 'def'
      assert.equal instance.size(), 1
      assert.equal instance.last(), 'def'
      instance.push 'ghi', 'jkl'
      assert.equal instance.size(), 2
      assert.equal instance.last(), 'jkl'

    # it "wires up .next properly", ->
    #   instance.push 'abc', 'def'
    #   prior_last = instance.last()
    #   instance.push 'ghi', 'jkl'
    #   assert.equal instance.tail().prev, prior_tail
      
    it "adds the pair at the head if no head existed previously", ->
      instance.push 'abc', 'def'
      assert.equal instance.first(), instance.last()

  describe "#pop", ->
    it "is a function", ->
      assert.equal typeof instance.pop, "function"

    it "removes a key value pair from the tail", ->
      instance.push 'abc', 'def'
      instance.push 'ghi', 'jkl'

      assert.equal instance.size(), 2
      assert.equal instance.last(), 'jkl'

      popped = instance.pop()

      assert.equal popped, 'jkl'
      assert.equal instance.size(), 1
      assert.equal instance.first(), 'def'

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
      assert.equal instance.first(), 'def'

      shifted = instance.shift()

      assert.equal shifted, 'def'
      assert.equal instance.size(), 1
      assert.equal instance.first(), 'jkl'

      shifted = instance.shift()

      assert.equal instance.size(), 0
      assert.equal shifted, 'jkl'

  describe "#unshift", ->
    it "is a function", ->
      assert.equal typeof instance.unshift, "function"

    it "adds a key-value pair as the head", ->
      instance.unshift 'abc', 'def'
      assert.equal instance.size(), 1
      assert.equal instance.first(), 'def'
      instance.unshift 'ghi', 'jkl'
      assert.equal instance.size(), 2
      assert.equal instance.first(), 'jkl'
  
    # it 'wires up .next properly', ->
    #   instance.unshift 'abc', 'def'
    #   prior_head = instance.head()
    #   instance.unshift 'ghi', 'jkl'
    #   assert.equal instance.head().next, prior_head

    it 'adds the pair as the tail if no tail existed previously', ->
      instance.unshift 'abc', 'def'
      assert.equal instance.first(), instance.last()


  describe "#get", ->
    it "is a function", ->
      assert.equal typeof instance.get, "function"

    it "retrieves a value by key", ->
      instance.push 'a', 'b'
      instance.push 'c', 'd'
      instance.push 'e', 'f'
      assert.equal instance.get('c'), 'd'

  describe "#insert", ->
    

  describe "#update", ->
    it "updates the value of an existing key", ->
      instance.push 'a', 1
      assert.equal instance.get('a'), 1
      result = instance.update 'a', 2
      assert.equal instance.get('a'), 2
      assert.equal result, true

    it "returns null and is a no-op if key isn't present", ->
      instance.push 'a', 1
      assert.equal instance.keys().length, 1
      result = instance.update 'b', 2
      assert.deepEqual instance.keys(), ['a']
      assert.equal instance.get('a'), 1
      assert.equal result, null

  describe "#remove", ->
    it "is a function", ->
      assert.equal typeof instance.remove, "function"

    it "removes a value by key, and rewires the remaining items", ->
      instance.push 'a', 'b'
      instance.push 'c', 'd'
      instance.push 'e', 'f'
      assert.equal instance.size(), 3

      value = instance.remove 'c'
      assert.equal value, 'd'
      assert.equal instance.size(), 2

      assert.equal instance.at(0), 'b'
      assert.equal instance.at(1), 'f'

      value = instance.remove 'a'
      assert.equal value, 'b'
      assert.equal instance.size(), 1

  describe "#keys", ->
    it "is a function", ->
      assert.equal typeof instance.keys, "function"

    it "returns an array of keys in insertion order", ->
      instance.push 'a', 1
      instance.push 'z', 2
      instance.push 'p', 3
      assert.deepEqual instance.keys(), ['a', 'z', 'p']
      instance.pop()
      assert.deepEqual instance.keys(), ['a', 'z']
      instance.shift()
      assert.deepEqual instance.keys(), ['z']

  describe "#forEach", ->
    it "is a function", ->
      assert.equal typeof instance.forEach, "function"

    it "iterates over the map", ->
      instance.push 'a', 1
      instance.push 'b', 2
      instance.push 'c', 3
      instance.push 'd', 4
      results = []
      instance.forEach [].push.bind(results)
      assert.deepEqual results, ['a', 1, 'b', 2, 'c', 3, 'd', 4]
  
  describe "#has", ->
    it "returns whether or not key is in the map", ->
      instance.push 'a', 1
      instance.push 'b', 2
      instance.push 'c', 3

      assert.equal instance.has('c'), true
      assert.equal instance.has('b'), true
      assert.equal instance.has('a'), true
      assert.equal instance.has('0'), false

    it "doesn't have crap like `constructor` or other inherited properties", ->
      assert.equal instance.has('constructor'), false
      assert.equal instance.has('hasOwnProperty'), false

  describe "#size", ->
    it "is a function", ->
      assert.equal typeof instance.size, "function"

    it "returns the number of items in the map", ->
      assert.equal instance.size(), 0
      instance.push 'a', 'b'
      assert.equal instance.size(), 1
      instance.push 'c', 'd'
      assert.equal instance.size(), 2
      instance.pop()
      assert.equal instance.size(), 1
      instance.pop()
      assert.equal instance.size(), 0

  describe "#first", ->
    it "is a function", ->
      assert.equal typeof instance.first, "function"

  describe "#last", ->
    it "is a function", ->
      assert.equal typeof instance.last, "function"

  describe "#at", ->
    it "returns the value for a given index", ->
      instance.push 'a', 1
      instance.push 'b', 2
      instance.push 'c', 3

      assert.equal instance.at(0), 1
      assert.equal instance.at(1), 2
      assert.equal instance.at(2), 3

      do instance.shift

      assert.equal instance.at(0), 2
      assert.equal instance.at(1), 3

    it "returns undefined for an out of range index", ->
      assert.equal instance.at(0), undefined
      instance.push 'a', 1
      assert.equal instance.at(0), 1
      assert.equal instance.at(1), undefined

  describe "#clear", ->
    it "is a function", ->
      assert.equal typeof instance.clear, "function"

    it "clears the map", ->
      instance.push 'a', 1
      instance.push 'b', 2
      instance.push 'c', 3
      assert.equal instance.size(), 3
      assert.equal instance.first(), 1
      
      instance.clear()

      assert.equal instance.size(), 0
      assert.equal instance.keys().length, 0
