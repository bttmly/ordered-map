# Ordered Map

## Methods

### `push(key, value) => Number size`
Adds `value` indexed by `key` to the map in the last position. If `key` is already in map, removes `key` before pushing.

### `pop() => value`
Removes the last mapping, and returns the `value`. If map is empty, returns `null`.

### `unshift(key, value) => Number size`
Add `value` indexed by `key` to the map in the first position. If `key` is already in map, removes `key` before unshifting.

### `shift() => value`
Removes the first mapping, and returns the `value`. If map is empty, returns `null`.

### `get(key) => value`
Returns the `value` for `key`, or `undefined`. Key access is O(1).

### `update(key, value) => `
Changes the value associated with `key` without changing the order.

### `remove(key) => Number size`
Deletes the key-value pair indexed by `key`.

### `keys() => Array keyStrings`
Returns an array containing the map's keys.

### `forEach(cb) => undefined`
Calls `cb(key, value)` for each key-value pair in the map.

### `has(key) => Boolean hasKey`
Returns a boolean indicating whether or not `key` is in the map. Uses the [`in` operator](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/in) under the hood.

### `at(Number index) => value`
Returns the value for the key at position `index` (zero-indexed, naturally). Random access is O(n) due to linked list traversal.

### `clear() => undefined`
Removes all keys and values from the map.

### `first() => value`
Returns the first value in the map without removing it.

### `last() => value`
Returns the last value in the map without removing it.
