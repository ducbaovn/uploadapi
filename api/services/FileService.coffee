fs = require('fs')
_ = require('lodash')
csv = require('csv')

exports.getData = (filePath, extend, done)->
  fs.readFile filePath, encoding: 'utf8', (err, data)->
    if err
      return done(err)
    
    if extend == 'csv'
      csv.parse data, rowDelimiter: '\n', (err, arr)->
        fields = arr.shift()
        if fields.length != _.uniq(fields, (n)-> n.toLowerCase()).length
          return done('Invalid data: Duplicate fields')
        db = []
        for values in arr
          obj = {}
          for i in [0..fields.length - 1]
           obj[fields[i]] = values[i]
          db.push obj
        return done(null, db)
    if extend == 'json'
      # Remove \n at begin and end of data string
      data = data.replace(/^[\s\n]+|[\s\n]+$/gm,'')
      data = data.replace(/\n/g, ',')
      data = '[' + data + ']'
      try
        data = JSON.parse data
      catch err
        return done('Could not JSON parse')
      return done(null, data)

exports.createModel = (data, model, primaryKey, done)->
  myArr = [
    "module.exports =",
    "  schema: true",
    "  autoPK: false",
    "  attributes:"]
  keys = _.keysIn(data[0])
  for key in keys
    type = typeof data[0][key]
    switch type
      when 'object'
        if data[0][key].constructor.toString().indexOf("Array") > -1
          type = 'array'
        else
          type = 'json'
      when 'number'
        type = 'float'
    myArr.push("    " + key + ":")
    myArr.push("      type: '" + type + "'")
    myArr.push("      primaryKey: true") if key == primaryKey
  mytext = myArr.join("\n")
  fs.writeFile sails.config.appPath + '/api/models/' + model + '.coffee', mytext, (err)->
    if err
      return done(err)
    return done(null)

exports.createController = (model, done)->
  content = "module.exports = {}"
  fs.writeFile sails.config.appPath + '/api/controllers/' + model + 'Controller.coffee', content, (err)->
    if err
      return done(err)
    return done(null)