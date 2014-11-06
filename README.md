# Ordered Map

## Methods

### `push(key, value) => Number size`
Adds `value` indexed by `key` to the map in the last position. If `key` is already in map, removes `key` before pushing.

### `pop() => Object value`
Removes the last mapping, and returns the `value`.

### `unshift(key, value) => Number size`
Add `value` indexed by `key` to the map in the first position. If `key` is already in map, removes `key` before unshifting.

### `shift() => Object value`
Removes the first mapping, and returns the `value`.

### `get(key) => Object value`
Returns the `value` for `key`, or `undefined`.

### `update(key, value) => `
Changes the value associated with `key` without changing the order.

### `remove(key) => Number size`
Deletes the key-value pair indexed by `key`.

### `keys() => Array keyStrings`
Returns an array containing the map's keys.

### `forEach(cb) => undefined`

### `has(key) => Boolean hasKey`
Returns a boolean indicating whether or not `key` is in the map. Uses `Object.prototype.hasOwnProperty()`, so it'll work fine when keys have values like `null` and `undefined`.

### `at(Number index) => Object value`

### `clear() => undefined`