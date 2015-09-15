exec = require('child_process').exec

exports.import = (filePath, model, extend, done)->
  exec 'mongoimport -h localhost:27017 --db uploadapi --collection ' + model + ' --type ' + extend + ' --headerline --file ' + filePath, (err, stdout, stderr)->
    if err
      return done(err)
    sails.log.info stdout
    return done()
