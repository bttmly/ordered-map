assert = require "assert"

OrderedMap = require "../src/index.coffee"

describe "OrderedMap()", ->
  it "is a function", ->
    assert.equal typeof OrderedMap, "function"

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
      assert.equal instance.size(), 1
      assert.equal instance.tail().key, "ABC"
      assert.equal instance.tail().value, "DEF"
      instance.push "GHI", "JKL"
      
    it "adds the pair at the head if no head existed previously", ->
      instance.push "ABC", "DEF"
      assert.equal instance.size(), 1
      assert.equal instance.head().key, "ABC"
      assert.equal instance.head().value, "DEF"

  describe "#pop", ->
    it "is a function", ->
      assert.equal typeof instance.pop, "function"

    it "removes a key value pair from the tail", ->
      instance.push "ABC", "DEF"
      instance.push "GHI", "JKL"

      assert.equal instance.size(), 2
      assert.equal instance.tail().key, "GHI"
      assert.equal instance.tail().value, "JKL"
      popped = instance.pop()
      assert.equal instance.size(), 1
      assert.equal instance.tail().key, "ABC"
      assert.equal instance.tail().value, "DEF"

      # consider the head/tail API vs. that of pop()/shift()
      assert.equal popped, "JKL"

  describe "#shift", ->
    it "is a function", ->
      assert.equal typeof instance.shift, "function"

    it "adds a key-value pair as the head", ->

  describe "#unshift", ->
    it "is a function", ->
      assert.equal typeof instance.unshift, "function"

  describe "#get", ->
    it "is a function", ->
      assert.equal typeof instance.get, "function"

  describe "#remove", ->
    it "is a function", ->
      assert.equal typeof instance.remove, "function"

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