MongoClient = require('mongodb').MongoClient
Waterline = require('waterline')

module.exports = 
  upload: (req, res)->
    params = req.allParams()
    filename = req.file('file')._files[0].stream.filename
    extend = filename.split('.')[1]
    if sails.models[params.key]
      res.send("This key has been used")
    req.file('file').upload 
      dirname: sails.config.appPath + '/testdata'
      maxBytes: 200 * 1000 * 1000
    , (err, uploadedFiles)->
      if err
        return res.send(500, err)
      FileService.getData uploadedFiles[0].fd, extend, (err, data)->
        if err
          return res.send(err)
        if typeof data[0][params.primaryKey] == 'object'
          return res.send("Invalid Primary Key: Primary Key should not be JSON")
        if data.length != _.uniq(data, params.primaryKey).length
          return res.send("Invalid Primary Key: duplicate values") 
        
        async.parallel [
          (cb)-> FileService.createModel data, params.key, params.primaryKey, cb
          (cb)-> FileService.createController params.key, cb
        ], (err, result)->
          if err
            return res.badRequest err
          url = 'mongodb://localhost:27017/admin'
          MongoClient.connect url, (err, db)->
            if err
              return res.badRequest err
            db.collection(params.key).insert data, (err, result)->
              if err
                return res.badRequest err
              return res.send "Upload Restful API successful!!!"