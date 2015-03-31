"use strict"

module.exports = (namespace, data) ->
  if data
    return localStorage.setItem namespace, JSON.stringify(data)

  store = localStorage.getItem namespace
  return (store and JSON.parse(store)) or []
