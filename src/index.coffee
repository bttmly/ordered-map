OrderedMap = ->

  storage = Object.create null
  head = null
  tail = null
  size = 0

  instance =

    push: (key, value) ->
      instance.remove(key) if instance.has key

      prior_tail = tail

      item =
      tail =
      storage[key] =
        key: key
        value: value
        prev: prior_tail
        next: null

      prior_tail?.next = item
      head = item unless head?
      return size += 1

    pop: ->
      return null unless tail
      prior_tail = tail
      tail = prior_tail.prev
      tail?.next = null
      size -= 1
      return prior_tail.value

    unshift: (key, value) ->
      instance.remove(key) if instance.has key

      prior_head = head

      item =
      head =
      storage[key] =
        key: key
        value: value
        prev: null
        next: prior_head

      prior_head?.prev = item
      tail = item unless tail
      return size += 1

    shift: ->
      return null unless head
      prior_head = head
      head = prior_head.next
      head?.prev = null
      size -= 1
      return prior_head.value

    get: (key) ->
      ret = storage[key]?.value
      return if ret? then ret else null

    update: (key, value) ->
      item = storage[key]
      if item?
        item.value = value
        return true
      return null

    remove: (key) ->
      item = storage[key]
      return null unless item?

      if item is head
        return instance.shift()

      if item is tail
        return instance.pop()

      item.prev?.next = item.next
      item.next?.prev = item.prev
      size -= 1

      return item.value

    keys: ->
      keys = []
      item = head
      while item?
        keys.push item.key
        item = item.next
      return keys

    forEach: (cb) ->
      item = head
      while item?
        cb item.key, item.value
        item = item.next
      return undefined

    has: (key) ->
      Object::hasOwnProperty.call storage, key

    size: -> return size

    tail: -> return tail
    
    head: -> return head

    at: (pos) ->
      i = 0
      item = head
      while i < pos
        i += 1
        item = item.next
      item.value

    clear: ->
      head = null
      tail = null
      storage = Object.create null
      size = 0
      return undefined

  return instance

module.exports = OrderedMap
